<?php


class ebyCSVParser
{
    /*!
     Constructor
    */
	var $Data;
	
    function __construct( $filename, $firstRowLabels = true,  $delimiter = ',' , $starParser = 0, $useColNameAsKey = false)
    {
        
    	$fp = fopen( $filename, "r" );
        $rows = array();
        $row = array();
		$key = array();
        // Load the file
        $i=0;
        
//eZDebug::writeNotice( 'ebyCSVParser: $starParser => ' . $starParser . ' $useColNameAsKey=>' . $useColNameAsKey, 'ebycsvparser.php');      
        while ( ( $data = fgetcsv( $fp, 1000, $delimiter )) !== FALSE)
        {
//eZDebug::writeNotice( 'ebyCSVParser: $data => ' . print_r($data,1), 'ebycsvparser.php');         	
        	if($useColNameAsKey && $i==0)
        	{	
        		$numCol = count($data);
        		for ($c=0; $c < $numCol; $c++) 
		        {
		            $key[$c] =  $data[$c];
		        }
//eZDebug::writeNotice( 'ebyCSVParser: $$key => ' . print_r($key,1), 'ebycsvparser.php');       	
        	}
        	
        	if($i >= $starParser)
        	{
	        	$numCol = count($data);
//eZDebug::writeNotice( 'ebyCSVParser: $data => ' . print_r($data,1), 'ebycsvparser.php');     	
		        for ($c=0; $c < $numCol; $c++) 
		        {
		        	if($useColNameAsKey)
		        	{
		        		$row[$key[$c]] =  $data[$c];
		        	}else{
		        		$row[] =  $data[$c];	
		        	}
		            
		        }
		        
	        	$rows[]=$row;
	        	$row = array();
        	}
        	$i++;
            
        }
        fclose ( $fp );

        $this->Data = $rows;
    	        
    }

    /*!
     return data
    */
    function data()
    {
        return $this->Data;
    }


    /// Member variables

    
}

?>
