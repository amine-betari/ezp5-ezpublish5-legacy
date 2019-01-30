<?php /* #?ini charset="utf-8"?

[IndexPlugins]
# Class override for solr indexation
General[]
General[]=ezfIndexBouygues

[IndexOptions]
OptimizeOnCommit=disabled

## If set to a positive value will add those delays with every addObject/removeObject call
# if set to 0 (default), it will be ignored
# the unit is milliseconds
CommitWithin=500

# DisableDeleteCommits=true|false
# Be careful with this option, deleted objects may still show up in search results, leading to (fatal) errors
# Make sure you have a frequent commit cronjob enabled if you set it to true to minimize errors
DisableDeleteCommits=true

# Since eZ Find 5.3 with Solr 4.x, you can enable soft commits which results in faster, yet lighter
# indexing and searching for write heavy installations
# By default, hard commits are issued every 15 seconds after any addition (soft commit
# or documents added without commit over the API)
# The value for the auto hard commits can also be changed upon Solr startup:
# Example: java -Dsolr.autoCommit.maxTime=30000 -jar start.jar guarantees hard commits
# after maximum 30 seconds
# EnableSoftCommits=true|false
EnableSoftCommits=true

*/

