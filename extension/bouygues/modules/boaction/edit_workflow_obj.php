<?php

/**
 * surcharge collaboration, add edit object dans le workflow validation
 * 
 * @author LIU Bin <robin_liu79@yahoo.fr>
 *
 */


$module		= $Params['Module'];
$namedParameters	= $module->getNamedParameters();
if( !isset( $namedParameters['objId'] ) || !isset($_POST) || count($_POST)==0 )
	return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel', array() );
	
if(!$object = eZContentObject::fetch( $namedParameters['objId'] ))
	return  $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel', array() );

$attribs = $object->fetchDataMap($namedParameters['objVersion']);

foreach ($attribs as $key => $att)
{
	$id = $att->attribute('id');
	store_attr($_POST, $att, $id);		
}
$object->store();
eZContentObject::clearCache( $object->attribute('id') );
$module->redirectTo($_SERVER["HTTP_REFERER"]);

	function store_attr($data, $contentObjectAttribute, $id )
	{
		// simple check
		if ( !is_object( $contentObjectAttribute ) )
		{
			return false;
		}
		$contentClassAttribute = $contentObjectAttribute->attribute('contentclass_attribute');
		$dataTypeString = $contentClassAttribute->attribute('data_type_string');
		//echo $dataTypeString ."<br />";
		switch ($dataTypeString)
		{
			case 'ezfloat' :
			case 'ezprice' :
				$contentObjectAttribute->SetAttribute('data_float', $data["ContentObjectAttribute_data_float_".$id]);
				$contentObjectAttribute->store();
			break;
			
			//case 'ezdate' :
			//case 'ezdatetime' :
			case 'ezinteger' :
			case 'ezsubtreesubscription' :
			case 'ezobjectrelation' :
				$contentObjectAttribute->SetAttribute('data_int', $data["ContentObjectAttribute_data_integer_".$id]);
				$contentObjectAttribute->store();
			break;
			case 'ezdatetime' :
				$year = $data["ContentObjectAttribute_datetime_year_".$id];
				$month = $data["ContentObjectAttribute_datetime_month_".$id];
				$day = $data["ContentObjectAttribute_datetime_day_".$id];
				$hour = $data["ContentObjectAttribute_datetime_hour_".$id] ? $data["ContentObjectAttribute_datetime_hour_".$id] : 0;
				$minute = $data["ContentObjectAttribute_datetime_minute_".$id] ? $data["ContentObjectAttribute_datetime_minute_".$id] : 0;
				$second = $data["ContentObjectAttribute_datetime_second_".$id] ? $data["ContentObjectAttribute_datetime_second_".$id]  : 0;
					 
				$dateTime = new eZDateTime();
	            $contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
	            if ( ( $year == '' and $month ==''and $day == '')  or
	                 !checkdate( $month, $day, $year ) or $year < 1970 )
	            {
	                    $dateTime->setTimeStamp( 0 );
	            }
	            else
	            {
	                $dateTime->setMDYHMS( $month, $day, $year, $hour, $minute, $second );
	            }
	
	            $contentObjectAttribute->setAttribute( 'data_int', $dateTime->timeStamp() );
	            $contentObjectAttribute->store();
			break;
			case 'eztime':
				$value = $data["ContentObjectAttribute_data_integer_".$id];
				if(is_numeric($value))
				{
					$tmpmin = $value / 3600;
					$hours = (int) $tmpmin / 60;
					$minute = $tmpmin % 60;
					$value = 	$hours . ":" . $minute;
				}
				$contentObjectAttribute->fromString( $value );
        		$contentObjectAttribute->store();
			break;
			case 'ezstring' :
				$contentObjectAttribute->SetAttribute('data_text', $data["ContentObjectAttribute_ezstring_data_text_".$id]);
				$contentObjectAttribute->store();
			break;
				
			case 'ezemail' :
			case 'ezisbn' :
			case 'eztext' :
			case 'ezurl' :
			case 'ezgpdistext' :
			case "ezhtml" :
				$contentObjectAttribute->SetAttribute('data_text', $data["ContentObjectAttribute_data_text_".$id]);
				$contentObjectAttribute->store();
			break;
			case 'ezselection' :
				$contentObjectAttribute->setAttribute( 'data_text', implode("-",$data["ContentObjectAttribute_ezselect_selected_array_".$id]) );
				$contentObjectAttribute->store();
			break;
			case "ezxmltext" :

				require_once 'kernel/classes/datatypes/ezxmltext/ezxmltexttype.php';
				require_once 'kernel/classes/datatypes/ezxmltext/handlers/input/ezsimplifiedxmlinputparser.php';
				$contentObjectID = $contentObjectAttribute->attribute('contentobject_id');
				$parser = new eZSimplifiedXMLInputParser( $contentObjectID, false, 0 );
				$document = $parser->process($data["ContentObjectAttribute_data_text_".$id]);
				if (is_object($document)) {
					$domString = eZXMLTextType::domString( $document );
					$contentObjectAttribute->setAttribute( 'data_text', $domString );
					$contentObjectAttribute->store();
				}
			break;
			case "ezboolean" :
				$value = isset($data["ContentObjectAttribute_data_boolean_".$id]) ? 1 : 0;
				$contentObjectAttribute->fromString($value);
				$contentObjectAttribute->store();
			break;
			default :
				return false;
			break;
		}
	}	
?>
