variable "users" {
  default = {
    #ravs:"Netherlands", 
    #tom:"US",
    #jane:"India"
    ravs : { country : "Netherlands", department : "ABC" },
    tom : { country : "US", department : "DEF" },
    jane : { country : "India", department : "XYZ" },
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.46"
}

resource "aws_iam_user" "my_iam_users" {
  for_each = var.users
  name     = each.key
  tags = {
    #country: each.value
    country : each.value.country
    department : each.value.department

  }


  #count = length(var.names)
  #name = var.names[count.index]
  #for_each = toset(var.names)
  #name = each.value
}




/*

terraform console


> var.names
{
  "jane" = "India"
  "ravs" = "Netherlands"
  "tom" = "US"
}
> var.names.jane
"India"
> var.names[jane]
╷
│ Error: Invalid reference
│ 
│   on <console-input> line 1:
│   (source code not available)
│ 
│ A reference to a resource type must be followed by at least one attribute access, specifying the resource name.
╵


> keys(var.names)
[
  "jane",
  "ravs",
  "tom",
]
> values(var.names)
[
  "India",
  "Netherlands",
  "US",
]
> lookup(var.names, "doe")
╷
│ Error: Invalid function argument
│ 
│   on <console-input> line 1:
│   (source code not available)
│ 
│ Invalid value for "inputMap" parameter: the given object has no attribute "doe".
╵


> lookup(var.names, "ravs")
"Netherlands"
> lookup(var.names, "ravs" "default")
╷
│ Error: Missing argument separator
│ 
│   on <console-input> line 1:
│   (source code not available)
│ 
│ A comma is required to separate each function argument from the next.
╵


> lookup(var.names, "ravs","default")
"Netherlands"
> lookup(var.names, "doe","default")
"default"
>  

*/
# why we need tfstate? known state? state purpose link
# Map the terraform objects to real world : compare known and actual STATE eg:type & name objects to cloud resources , AWS tags
# track dependenceis b'w rersources create/delete resource / need metadata
# act as cache tfstates - -- performance -refresh=false 


# until now local state we will move to remote state
# Git hub version control/not safe

#2.  why we are creating diff projects?
# best practice : for 1 project it might need s3 buckets, virtual servers, diff lifecycles
# separate for managing diff resources, initilaiser, manage diff states


#3. Bckup folder
# when working one specific project, make change in separet project
# change in main.tf in diff project so better to have backup folders



