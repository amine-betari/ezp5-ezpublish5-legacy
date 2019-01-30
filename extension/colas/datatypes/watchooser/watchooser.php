<?php

/**
 * Class de WatVideo
 */

class watChooser {

	protected $attributes = array(
									'id'				=> NULL,
									'parent_id'			=> NULL,
									'type'				=> NULL,
									'chaptered'			=> NULL,
									'title'				=> NULL,
									'description'		=> NULL,
									'user_id'			=> NULL,
									'login'				=> NULL,
									'parent_user_id'	=> NULL,
									'parent_login'		=> NULL,
									'tags'				=> NULL,
									'previews'			=> NULL,
									'url'				=> NULL,
									'language'			=> NULL,
									'player'			=> NULL,
									'status'			=> NULL,
									'visibleonwat'		=> NULL,
									'programtype'		=> NULL,
									'typeoeuvre'		=> NULL,
									'created'			=> NULL,
									'modified'			=> NULL,
									'startdate'			=> NULL,
									'enddate'			=> NULL,
									'hd'				=> NULL,
									'diffusions'		=> NULL,
									'chaineid'			=> NULL,
									'rubriqueid'		=> NULL,
									'externalid'		=> NULL,
									'heliosTheme'		=> NULL,
									'duration'			=> NULL,
									'display'			=> NULL,
									'thumb_maxi'     	=> NULL, // 480x270
									'thumb_normal'   	=> NULL, // 220x124
									'thumb_medium'   	=> NULL, // 200x150
									'thumb_mini'    	=> NULL, // 120x90
									'json'           	=> NULL
									);
	
	public function __construct($json) {
		$this->fromJson($json);
	}
	
	public function attributes () {
		return array_keys($this->attributes);
	}

    public function wat_attributes() {
        return $this->attributes;
    }


    public function attribute ($name) {
		$return = null;
		if (!empty($this->attributes[$name])) {
			$return = $this->attributes[$name];
		}
		return $return;
	}
	
	public function hasAttribute ($name) {
		return array_key_exists($name, $this->attributes);
	}
	
	public function __get( $name ) {
		return $this->attributes[$name];
	}
	
	public function __set( $name, $value ) {
		$this->attributes[$name] = $value;
	}
	
	public function toJson() {
		$data = new stdClass();
		foreach ($attributes as $key => $value) {
			$data->$key = $value;
		}
		return json_encode($data);
	}
	
	public function fromJson( $json ) {
		$data = json_decode($json);
// 		echo '<pre>';
// 		foreach (array_keys((array)$data) as $attr) {
// 			echo '									\'', $attr, '\'', "\t\t\t", '=> NULL,', "\r\n";
// 		}
// 		echo '</pre>';
// 		die();
		$this->json = $json;
		foreach ((array)$data as $key => $value) {
			if ((is_object($value)) || (is_array($value))) {
				switch ($key) {
					case 'tags':
						$value = implode(', ', $value->tag);
						break;
					case 'previews':
						$this->thumb_maxi	= $value->preview[0]; // 480x270
						$this->thumb_normal	= $value->preview[1]; // 220x124
						$this->thumb_medium	= $value->preview[2]; // 200x150
						$this->thumb_mini	= $value->preview[3]; // 120x90
						$value = serialize($key);
						break;
					case 'display':
						$embedframe = null; 
						foreach ($value->format as $url) {
							if (mb_strpos($url, 'embedframe') !== false) {
								$embedframe = $url;
								break;
							}
						}
						$value = $embedframe;
						break;
					default:
						$value = serialize($key);
						break;
				}
			}
			$this->$key = $value;
		}
	}
	
	public function __toString() {
		return serialize($this->attributes);
	}
}