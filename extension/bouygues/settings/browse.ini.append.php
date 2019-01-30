<?php /* #?ini charset="utf-8"#

# Action for finding related object id
[AddRelatedSingleObject]
StartNode=content
SelectionType=single
ReturnType=ObjectID


[AddRelatedMultipleUser]
StartNode=users
SelectionType=multiple
TopLevelNodes[]
TopLevelNodes[]=users
Class[]
Class[]=user
ReturnType=ObjectID


[AddNodeMultiple]
StartNode=content
SelectionType=multiple
ReturnType=NodeID


*/