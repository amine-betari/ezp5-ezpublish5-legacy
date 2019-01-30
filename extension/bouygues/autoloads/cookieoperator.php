<?php
include_once( "extension/bouygues/classes/ebycookie.php" );

class CookieOperator
{
    function CookieOperator()
    {
        $this->Operators= array( 'cookieset', 'cookieget' );
        $this->Debug = false;
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
        return false;
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'cookieset':
            {
                $operatorValue = $this->cookieSet( );
            }
            break;
            case 'cookieget':
            {
                $operatorValue = $this->cookieGet( );
            }
            break;
            
        }
    }

    function cookieSet()
    {
    	if(eZSys::requestURI() != '/'){ 
			$url = eZSys::requestURI();

			if(!isset($_COOKIE['pages'])){
				setcookie('pages', $url, time()+2592000, '/', '', false, true);
			}else{
				$arrUrls = explode(';',$_COOKIE['pages']);
				$strTemp = $url.';';
        	
				$count = count($arrUrls); $i = 1;
				foreach($arrUrls as $urlTmp){
					if($i < 10){
						if($i < $count)
							$strTemp .= $urlTmp.';';
						else
							$strTemp .= $urlTmp;
        	
					}else
						break;
        	
					$i++;
				}
				
				setcookie('pages',$strTemp, time()+2592000, '/', '', false, true);
			}
		}
      	return true;
    }

    function cookieGet()
    {
    	if(!isset($_COOKIE['pages'])){
			return array();
		}else{
			$arrUrls = explode(';',$_COOKIE['pages']);
		}

      	return $arrUrls;
    }

    
    /// \privatesection

    /// \return The class variable 'Operators' which contains an array of available operators names.
    var $Operators;

    /// \privatesection
    /// \return The class variable 'Debug' to false.
    var $Debug;

}

?>
