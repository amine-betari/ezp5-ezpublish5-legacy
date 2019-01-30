<?php
class FetchSection
{
    function FetchSection()
    {
        $this->Operators= array( 'setSection', 'getSection' );
        $this->Debug = false;
        $this->Cache = false;
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
             
        	'setSection' => array(
	        	'section_id' => array(
	                'type' => 'int',
	                'required' => true
	             )
	         )
             
        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'setSection':
            {
            	
                $operatorValue = $this->setSection($namedParameters);
            }
            break;
       	  	case 'getSection':
            {
            	
                $operatorValue = $this->getSection();
            }
            break;
            
        }
    }

    function setSection($namedParameters)
    {
		$_SESSION['section_id_environnement'] = $namedParameters['section_id'];
		return $_SESSION['section_id_environnement'];
    }
    
    function getSection(){
    	return ($_SESSION['eZGlobalSection']['id']);
		//return $_SESSION['section_id_environnement'];
    }


    var $Operators;
    var $Debug;

}

?>
