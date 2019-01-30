<?php

class youtubeChooser {

	protected $attributes = array(
									// Custom attribute
									'videoId'           => NULL,

									// Default attributes from JSON received via YouTube API
									'publishedAt'       => NULL,
									'channelId'         => NULL,
									'title'             => NULL,
									'description'       => NULL,
									'thumbnails'        => NULL,
									'channelTitle'      => NULL,
									'playlistId'        => NULL,
									'position'          => NULL,
									'resourceId'        => NULL,

									// Custom attributes
									'tags'              => NULL,
									'tagsArray'         => NULL,
									'thumb_default'     => NULL, // 120x90
									'thumb_medium'      => NULL, // 320x180
									'thumb_high'        => NULL, // 480x360
									'thumb_standard'    => NULL, // 640x480
									'thumb_maxres'      => NULL, // 1280x720
									'url'               => NULL, // YouTube view full URL
									'iframeUrl'         => NULL, // YouTube iframe embed URL
									'json'              => NULL
									);

	public function __construct($json) {
		$this->fromJson($json);
	}

	public function attributes () {
		return array_keys($this->attributes);
	}

	public function youtube_attributes() {
		return $this->attributes;
	}


    public function attribute ($name) {
		$attribute = null;
		if (!empty($this->attributes[$name])) {
			$attribute = $this->attributes[$name];
		}
		return $attribute;
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

	public function fromJson( $json ) {
		$data = json_decode($json);
		$this->json = $json;
		foreach ((array)$data as $key => $value) {
			if ((is_object($value)) || (is_array($value))) {
				switch ($key) {
					case 'tags':
						$this->tagsArray = $value; // Store 'tags' (which is originally an array) into 'tagsArray'
						$value = implode(', ', $value);
						break;
					case 'thumbnails':
						$this->thumb_default    = $value->default->url; // 120x90
						$this->thumb_medium     = $value->medium->url;  // 320x180
						$this->thumb_high       = $value->high->url;    // 480x360
						$this->thumb_standard   = $value->standard->url;// 640x480
						$this->thumb_maxres     = $value->maxres->url;  // 1280x720
						$value = json_decode(json_encode($value, JSON_HEX_AMP), true);
						break;
					case 'resourceId':
						$this->videoId = $value->videoId;
						$value = json_decode(json_encode($value, JSON_HEX_AMP), true);
						break;
					default:
						//$value = serialize($value);
						$value = json_decode(json_encode($value, JSON_HEX_AMP), true);
						break;
				}
			}
			else {
				switch ($key) {
					case 'publishedAt':
						$value = str_replace('T', ' ', $value);
						$value = str_replace('.000Z', '', $value);
						break;
					case 'description':
						$value = nl2br($value);
						break;
					default:
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
