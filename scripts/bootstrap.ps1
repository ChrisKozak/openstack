#ps1

$pem = @'
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAtovJJ/KGdqYIj3hMWwuptjtdNYUmuPqUqP6PoBDYT8nfI6Ct
oiN7Hl1rRbAjxLYE41LhkBHnEsEbzANrzoTYxPAHTMAF++36qmYVA/CCK7mAjHIg
FTT1+YMqPPE0AD8w2eQX6Cr2m/KAtUjH/WpCQeXlEJuQkJ1P74oXRWG9o1YsmFp2
GvhzFGw0cUL1LUIqctLBIrvlxR+KMkAudaKLMQ1QV0N0Yqe/mSTRJ8hBDHLJHKNU
wfB9waoWLgD4cM2mEjBsIFTScqpJFEBSN+wlBTIM1o8mcvWjMSx33fsKrxNBCPp9
JKL5QZNC0cf3kSLuy1Obd3+3nRb+dfRHjZZvlwIDAQABAoIBAQCyR2Dkj7p8w/jW
TXGc9Y4AuId2jpzbyXZIeZzBgdIQUqKHhBQvpqFGbYwnmjfElNO/Q6Ghd6qKKWjB
XZH7NskRxS4L6fmuKqRFqL7bgxdOJrQB9i+ZJokX7t7gd90GZLCMDHTAvLzuXu8O
nY8b0pv1CdYl2xhb9BcuZVoG28c+bXCwkLVGHOe1nEl8UYwW1VvnYVLIRaNt1IOO
fbiYwL7HDs5s6xnq7aIVs22FfuOUAzVZsLROjVHhmAwojUxE7f7jsS/Kt0mnzF66
341TTqFhuwnWNB12c6algy4/1Ji5t5Fm0iF1vmHtX47I9DuuN8/J53OKg3b5i78n
6ELdoP8pAoGBAPLecH9hcBvbmGKWR98daMOJK328/Rddld9YOeryRFjPnmVebHlJ
V19MsoLlhGcdQ0YHhO8SBBcNI+cq51m1ohe6x5ucQzqiZu2V7y94QHJ1jNuErEhZ
rCaGuqLqPd2ljT5nMiNMdEuQH6TgdVoLo+tjLcgWtLOQK3l5SW/3kXBVAoGBAMBq
ah9Vk19gEobGW7iTYI1wUWSxRQ6V5wGtRlzD6d4l4SzMzA7w8290wuT+0RFnAlN8
kw5dcHssAtfH0JxHRi28/Tuk14MXPtbyYftL3i/SZwLg5zl9R17pViCAjXYgUQeq
f/OUuWer7yJ6b5k4UfkJagjao7V9EoWJTHdm51w7AoGAQgbZPLgnu1sa9Yp3pZ+g
MLClAz0S7XxC14Jr1ITiseZX4KUoBl07BKycR1vQgBwDgxFeQYR7Wiz3WsxeMxRf
KeZch+CWomUuaF7/tL8TfkqY7cEG+XBvjdXI/auDADQWzyVNCy2o3DYldDSVktJh
UQgYlTIfFEYYm6Cup2L9xjUCgYB8f14S0Cf+ugbCtW17S8BZQ6cmY5yvB0bkytyQ
ASM83X2IoyoVMMoR/5Zq3IUhoWjb4+qyjLrOt3dPbrYHqAY8ad/fy5S1+UBri4Di
PACTKKwGLMbvZ6PaQVe8x/C/0cEcGLGZRU2BSrn7sQSsOsivPewhtnXeZAKr7F5R
k393KQKBgByQ3v5PkQGBZIL/G95uldZ29iYWr/qZWiRGfmZVjvc79wdhRcBSn3TQ
Hal7rIsIKxJVHEfZu48RL9TuurOksA5T3RPQgsHWNtogH5DvHgqkvgPcThgZuGx9
Uh7eE43UNYavsHjxCJMGlZveBgkEe0WnOqe1IDbqAxGZznoUM20A
-----END RSA PRIVATE KEY-----
'@

mkdir c:\chef
set-content 'c:\chef\validation.pem' $pem

$client = @"
chef_server_url 'https://10.71.144.13'
node_name "app.ulti-cloud.com"
validation_client_name   'chef-validator'
validation_key           "c:/chef/validation.pem"
"@

set-content 'c:\chef\client.rb' $client

$webclient = New-Object System.Net.Webclient
$webclient.DownloadFile("https://opscode-omnitruck-release.s3.amazonaws.com/windows/2008r2/x86_64/chef-client-11.4.0-1.windows.msi","C:\chef-client-11.4.0-1.windows.msi");
start-process C:\chef-client-11.4.0-1.windows.msi /quiet -wait

start-process C:\opscode\chef\bin\chef-client -argumentList '-o "recipe[app_test]"' -wait
