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
