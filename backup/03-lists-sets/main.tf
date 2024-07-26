variable "names" {
    default = ["ravs", "sats", "sonia", "minu", "keerthi"]
    #default = ["sonia" , "minu", "keerthi"]
}

provider "aws" {
    region = "us-east-1"
    version= "~> 2.46"
}

resource "aws_iam_user" "my_iam_users" {
    #count = length(var.names)
    #name = var.names[count.index]
    for_each = toset(var.names)
    name = each.value
}


/*
 > var.names
[
  "sonia",
  "minu",
  "keerthi",
]
> var.names[0
: ]
"sonia"
> length(var.names)
3
> reverse(var.names)
[
  "keerthi",
  "minu",
  "sonia",
]
> distinct(var.names)
tolist([
  "sonia",
  "minu",
  "keerthi",
])
> toset
╷
│ Error: Invalid reference
│ 
│   on <console-input> line 1:
│   (source code not available)
│ 
│ A reference to a resource type must be followed by at least one attribute access, specifying the resource name.
╵


> toset(var.names)
toset([
  "keerthi",
  "minu",
  "sonia",
])
> concat(var.names, "new value")
╷
│ Error: Invalid function argument
│ 
│   on <console-input> line 1:
│   (source code not available)
│ 
│ Invalid value for "seqs" parameter: all arguments must be lists or tuples; got string.
╵


> concat(var.names, ["new value"])
[
  "sonia",
  "minu",
  "keerthi",
  "new value",
]

> contains(var.names, "ravi")
false
> contains(var.names, "sonia")
true
> sort(var.names)
tolist([
  "keerthi",
  "minu",
  "sonia",
])

range(10)
tolist([
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
])
> range(1,12)
tolist([
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
])
> range(1,12,2)
tolist([
  1,
  3,
  5,
  7,
  9,
  11,
])
> range(1,12,3)
tolist([
  1,
  4,
  7,
  10,
])
>  

*/


