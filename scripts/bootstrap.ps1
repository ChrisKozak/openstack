#ps1

$pem = @'
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA37yNL+40mRHEEsSWqVWgS3klq2i7pIyIkEszuJAdY6XAevCv
OQNlCh6XiOhufNR7U6AfBUIACSHyP573AL99lsEZIVzkiv38a19QKbiUEvfiz3Wq
7tjfJ9uQTfELlY2YaAGWX31c9lpVPJN1qQGGs6IHXXKtoz5CePHevtO2UEVyutDq
hSWEEPCABgwCZsRn6vnTeyX5mFhcLtL7aUi2L2WpTUaZb2sAZTeSwxQ44dXjYWzS
v7xIs3oRF7XIMmvTRBnZv8ZiGlwQfdzC6cKASg0NuL+lTDWjasDo5H+oJmcfnDIM
GJteyDUZzJcjjE72Ngyg72W++WZ6L5T6lZfjsQIDAQABAoIBADab0uor/fKOf4kF
KrDSEXnaa/NWcNZM5tgxQsJ9im7T+hMHw/zqczLxHJNyB+W4BxH2NxwVa+TOwE3/
AtLP6lttbjDSd4XlUEL01KAaSSoIDvgMBFif3nfgA2zCtM0f7l8UZBuSgaovijZq
14EUukgF+D46y17Yx2i1wGRbUFhu5im7dAEdFyzH4FOYCVgIMJA/voy2gKfqpXmU
iiVW0P1E0XhLJ7haUHPsqlLjpcORD9e4jpR2RM96aIA4m7iE5Oy3QyjeuZcwgp2t
kTfbKQxoQrFCcuD1T+zdGczH8KxAn0pSaysPHbjOTiWSlnarGkApN5R5H31i4P5Y
4SqfbXECgYEA748xbQrT+XMwEQ1WD3YFOudWuW7dUUNVgVQbx0mtvPLDEpM2v0fz
NpGTM1PLgdhftYK7RJO/4/eU+/gpcaqmYzUAxS5kbC0pYg20DJVwxSFiespVASWY
qJc3t6nFYXPBuIFAbvsoiQ4fLVKD84zjRzMDcsWXiype0WYQfRDMBecCgYEA7xde
OuRgIeuL286le1uAPRNAiUzsUxaK7j9hbTIXMP5RkJA/3Su5dLawXy+Oe2L5jKpC
ERF4Pn0LLCB9nYGNRchbd4jWn1ilsHOc6z9xqRz+k82fQpmVOD8xxJBqzxzkVnpd
Q8n/yR3zPmtW6nTNCYrSg8ongVsff8wcumfqZqcCgYEApGBj8MdyRgMk4z58Y+V+
lzlvx5Nr5zvFqxU0bl1/ClylP9Slx0CugS4IjDqeNH1sxtZqexbKn7kdkHtqrKUE
wKP44FQB8jxW3gI7HjtYgttygIDfLQdIJb6FK9AhMMpGDb0aokxSNyDqgaXSBscQ
mKVHY3RzlLlBEHvxKm/hHtcCgYEAoxICIBLBioEYK/xem6tF5OIroznG+cinS2YJ
Miv262CaCwqHtHbtD7DGzLUn7foMkKdTVkbfB2fL5fXnFzVUQKMt13KKR7Zzk8zW
2xCzmg9/hxm4pPkRcIKRlCqX3tkq19yvndu5TNfTnuAhMNonOnnnqSGJHk4jRsvV
UEIt+oMCgYAHjUWEVRquyEXTajEHNR87LRy5g74902NbdAK89zcRINmDXTBYbseT
ghObOFCrIqBQB/K1/7gofUdqqp1mn3od2wOWTGPkV6JvyYqnP5Sz092aRWOly47R
sYMUA+An4bcniaRDT9BbBy1EfCJKNJoBWB6fcMHebwV+zEFso5q8Ew==
-----END RSA PRIVATE KEY-----
'@

mkdir c:\chef
set-content 'c:\chef\validation.pem' $pem

$client = @"
chef_server_url 'https://192.168.100.4'
node_name "$(hostname)"
"@

set-content 'c:\chef\client.rb' $client

$webclient = New-Object System.Net.Webclient
$webclient.DownloadFile("https://opscode-omnitruck-release.s3.amazonaws.com/windows/2008r2/x86_64/chef-client-11.4.0-1.windows.msi","C:\chef-client-11.4.0-1.windows.msi");
start-process C:\chef-client-11.4.0-1.windows.msi /quiet -wait

cd c:\chef
c:\opscode\chef\bin\chef-client
