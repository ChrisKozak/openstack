#ps1

$pem = @'
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAzPfv87lDSrtzOWJaddfppvYryuViyDbaVxQBMCH/MF9TWZSR
vvQerGz+aDf0niARhrV8mcPjYoHTkj24chhEN/fCqCZVPHiPf9diyIVmHpDqg26x
hq18RUFLdt++zrpNYZR0678AODBJzmOJ2hr1hfQo0uwafFtlJaeu+kA51huHRrad
bazmfAkDh2W4XndUoeCxW0IvSGuPMiz9YHBkw3hz8fEOwNEY37Wizsx1cU/bjmYk
tv0Jo9E4uEbYFXg8MvJK1R9BVJF2gjQ1huJravP7Qc/V4TORfy2B4Db8AL+nqAKE
ohsu3DRRGT/LB8GFeJ9kF3tG3Mf2dpOKQgMdMwIDAQABAoIBAQCT0bubaeC95LIU
kHnswuofHyo2CXhULDsK0cKJk/sWR6k00ZDKxgPZFkHjp3cjEr2RCRHzUvKJ+Fc9
AIYkwptwQZ6A5iRSmB/lctArDQm4wYpff1VIa5VT3OMvt+1D6dgkp4wq+HSQEUMp
NWAVi5vGH2/RrbTsOn2XynbGw8ryPV3IV6c/374PRwHdfXfbdBx5Mel6EmHAFycK
pAHp4lB8533mEztzZi+jc/F1ogCET7WsYMfVia0fvlQcy7vaP5DcYR3vMyG03TUg
ZlbMzaYbb2CWQ4I2HGz+M4rG1IRh2FygNV1mQCGovHqwYIHh6qk+dwj8CfWkKmIV
jkXaGWsBAoGBAObTp1ErL3Yy2zOB67v91DKBxLOPqXlItJeojb73ffvh+qmzfgoE
jivLqs5fOenKy9Kdc4DN0qK9MvlmJrGLrx0MQO2InC2l/pzM0ZNC0VKULjvGlvFt
SATqQlWJkIHHfA48fQZrm/+yaanBqjUij+3zjUpSrz4iHQx7ER/pfYdVAoGBAONS
W9Khx85R0VZ/J14rtWBG2ydUBnKmJP0/YSAtIItgaH/QeAlhFX+oj9RiS1zRlet/
THxx/zrTUS8OAo1JgdNBzq/i3XXp2z7xYUuAA01OmLSIBqtKVGS/CJb2oekHtgBq
NfM7BEEkFP3C5ei7LmlduX3YzM4RrSIjzi7ZpwJnAoGADvq7R/Qyf0wrl3sd7jQ5
uhFbz39KMzm5poHkuPjcryTqHGsuib3j8Ammiv/5BSgI9CENptU0jyUSEsdDSZBU
C+GIsSGFaRz1mf1cuF7EsMQ2/+ASWZaK7u644U4tF473iQD56BnBpOVSIBcWUZ5t
kraUe7dD8hdKpU2zPcvsPoUCgYBPtV1FKj0pdz70GXnwZ1sd+zp1O91W7jMiKcsg
wTIcLR33U14Dy+sB7FUin6TVUxhCj0x+hmp8cgSRf1QdvpyrOvQCcIY/BlU+aN04
4BZIUTrycpAEF/gnq2STqr9zOqTy2Es6koMXZFOH94MubBQGFjsoiZCm4UPYKL3v
Z5pMGQKBgHORonF8slL0dw4SwMgidNa52t5ti4MCtXy6HIXKHrA0zLB7przd7xAd
1Ks3K4seeoBJcnYV9JVU1MPSflSEqNzNyYNEnuUOVD1HtJHe8FcBCbkSKU7EcIXM
ftpn0+xOb9h++rMg+oye890pAgVs4bDMudAYHz7gpOz8geSC0EWt
-----END RSA PRIVATE KEY-----
'@

mkdir c:\chef
set-content 'c:\chef\validation.pem' $pem

$client = @"
chef_server_url 'https://chef.ulti-cloud.com'
node_name "db.ulti-cloud.com"
validation_client_name   'chef-validator'
validation_key           "c:/chef/validation.pem"
"@

set-content 'c:\chef\client.rb' $client

$webclient = New-Object System.Net.Webclient
$webclient.DownloadFile("https://opscode-omnitruck-release.s3.amazonaws.com/windows/2008r2/x86_64/chef-client-11.4.0-1.windows.msi","C:\chef-client-11.4.0-1.windows.msi");
start-process C:\chef-client-11.4.0-1.windows.msi /quiet -wait

start-process C:\opscode\chef\bin\chef-client -argumentList '-o "recipe[database_test]"' -wait
