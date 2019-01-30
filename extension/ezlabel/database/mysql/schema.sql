CREATE TABLE ezlabel (
 `id` int(11) NOT NULL auto_increment,
 `owner_id` int(11) NOT NULL default '0',
 `creator_id` int(11) NOT NULL default '0',
 `created` int(11) NOT NULL default '0',
 `name` varchar(255) NOT NULL default '',
  PRIMARY KEY ( `id` )
);

CREATE TABLE ezlabel_object (
 `label_id` int(11) NOT NULL default '0',
 `contentobject_id` int(11) NOT NULL default '0',
 `creator_id` int(11) NOT NULL default '0',
 `created` int(11) NOT NULL default '0',
  PRIMARY KEY ( `label_id`, `contentobject_id` )
);
