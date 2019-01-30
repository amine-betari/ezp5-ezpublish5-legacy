<?php


class BylinkOperator {

    private $Operators;

    function __construct()
    {
        $this->Operators = array(
            'bylink_i18n',
            'word_cut',
            'get_filiere_name',
            'ez5_get_parameter',
            'get_node_id_from_remote_id'
        );
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    public function namedParameterList()
    {
        return array(
            'word_cut' => array(
                'first_param' => array('type' => 'int', 'required' => false, 'default' => 10),
                'second_param' => array('type' => 'string', 'required' => false, 'default' => ''),
                'third_param' => array('type' => 'string', 'required'  => false, 'default'   => ''),
                'fourth_param' => array('type' =>  'string', 'required'  => false, 'default'   => ''),
            ),
            'get_filiere_name' => array(
                'section_id' => array('type' => 'int', 'required' => false, 'default' => 10)
            ),
            'ez5_get_parameter' => array(
                'parameter' => array('type' => 'string', 'required' => true)
            ),
            'get_node_id_from_remote_id' => array(
                'remote_id' => array( 'type' => 'string', 'required' => true )
            ),
        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace,$currentNamespace, &$operatorValue, $namedParameters )
    {
        if ($operatorName == 'get_filiere_name')
        {
            $operatorValue = $this->getFiliereName($namedParameters['section_id']);
        }
        elseif($operatorName == 'word_cut')
        {
            $operatorValue = $this->wordCut($namedParameters['first_param'],$namedParameters['second_param'],$namedParameters['third_param'],$namedParameters['fourth_param']);
        }
        elseif ($operatorName == 'ez5_get_parameter')
        {
            $operatorValue = $this->ez5GetParameter($namedParameters['parameter']);
        }
        elseif ($operatorName == 'get_node_id_from_remote_id')
        {
            $operatorValue = $this->getNodeIdFromRemoteId($namedParameters['parameter']);
        }
    }

    /**
     * This function cuts a string at word boundary
     * @param string $str : string to modify
     * @param int $cnt : Number of words to retain
     * @param string $complete
     * @param boolean $space true si espace avant le complète (Pas correct si ... dans la typographie francaise)
     * @return string : The shortened string
     */
    public static function wordCut(  $cnt, $str, $complete, $space )
    {
        $words = preg_split( ',\s+,', $str, -1, PREG_SPLIT_NO_EMPTY );
        if ( count( $words ) > $cnt )
        {
            $str = implode(' ', array_slice( $words, 0, $cnt) );
            $str .= $space . $complete;
        }
        return $str;
    }


    public static function getFiliereName($sectionId){
        switch ($sectionId) {
            case 7:
                return 'Communication';
            case 6:
                return 'Consolidation';
            case 8:
                return 'Controle interne';
            case 9:
                return 'Développement durable';
            case 10:
                return 'Europe';
            case 11:
                return 'Finances';
            case 16:
                return 'Groupe';
            case 15:
                return 'IMB';
            case 12:
                return 'Informatique';
            case 13:
                return 'Innovation';
            case 14:
                return 'RH';
            case 18:
                return 'Juridique';
            case 19:
                return 'Ebysa';
            default:
                return 'Standard';
        }
    }


    public static function ez5GetParameter($param){
        $container = ezpKernel::instance()->getServiceContainer();
        return $container->getParameter($param);
    }

    function getNodeIdFromRemoteId($remoteId) {
        $object = eZContentObject::fetchByRemoteID($remoteId);
        if(is_object($object)) return $object->mainNode()->attribute('path_string');
        return '';
    }

} 