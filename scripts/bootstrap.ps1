#ps1

$pem = @'
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAxKF4UPIX8lF35j9dNRqefNHOW71roEMUuuyEU0ywbyj4ZCjU
yCQlreisfAPrIXGKTuXRRw2pzM8xhRILIqyHa4uFpktXV73xrC1HjDKBaGH3nlRB
i3y7CwCjxiQA64hIJnCCTYJMFwSE2SH92uxuzgO8mV3SU6Ntd1fiaqwd0vn8+8jV
YV9f8oPMaRS2t+lmq32WjgH46R+VLGGzR/VxPIWaxx13uBqsTaFzSmuDe0cEFT0r
pUKBafjdjNEZ6Yb9RCL8KQvvRBUUto2sStfUDfVoC4fsQ/ltR1fO9dyjjHaTwwaY
mPWi0aWLZKG7mpRFiZIcQ43Gz4WiSkGpByifdQIDAQABAoIBAQCfuuO4LdHSIOgb
fGHFH8ibcPwHfkqNt7CBYFzmJig1RLzy8FBZ/TM2oQps++noEwndqcdlxu2m2LFL
firZkfm4HXEGc7GSL1TBH089zlFdcCfs0FkmbL6s42onLVwp+V1TDJZtTGlvUVZx
5LEJRIOGi3aLx7FyDBKCnjvpl8Pqe4an0tmJJR2eM9D602JCRcT+bvC52kJUAV9o
PxnYEZAusWEFKKk31K11JwQWf/rirG5rmFiKTMe5vvQWRUQGziAQczvRTW6Zs8jC
6RtetLTLX6SnZV5TXWubC1npZ9dtEzBBmm2+vbY0wjH2vs4QHPOAqZlK4Ro7+WoT
9cLunBWJAoGBAPn0mTVILWIyNfsDQ2lTQQSJwxCrvED7h18UdsnnjJq9wbfiqykv
DvyiEHaxsWOTFyi+e9CumjwcgN/3Knab9EX859NOJ4sQGtO5jU2W6t/35nHbVKYM
NhST+cXX8rMqaG1Ms+rZsJfPSM51sYXsbi6C5yr8mIKBI2ff4XRR9OKXAoGBAMli
wPG4M+k2T0O0Xno67boPjWwihSIjmy0c4K2yQTHRnBnyvTuFEIvbSNoQRyxeIq0N
HN8yX6uggogkpuzMGJylPhT5RsaXT8lz8Bim8SiYfBQEDDNzfyV1QUGiKTdTG3HF
RtzAFvtSQowEC1rp4spq2D/Rh8Ahx+afu5WKoavTAoGAH54jKyxAIWW8kk3tXwta
9BoBBMDUhVvL2ekaxZt2m7RZJsuTXxhGywotDvaXO8NFcK/3tYQAmo34d1wqkOpV
Ue0V3hLKybp1ykZ0a1Yly8Lt8YUPBhoRVTUKqU4RszwwDXNgZtq2jd14ljUpCYnI
vjVszHE7UXbIZcFaIX6kfW0CgYB5yI6Fnq9FyOIGP30izaAVdHJBgl6gVofwsBXu
9G0Yg3my92gYJk/rQ6C6vj1MR2EQ5W0gTIYuc9J8Ii4P5Ry9HfB9HoH+dmJ5oPMA
9XPA6PWf5RK7yoyJSm88EaR7IHboRjSkKkW7lfNIWOnFAMt1PUeo0D0Xo1YP0WjO
9hbuoQKBgDilT6DdoQ+DpaVk0915HyAbMo/zguscVa6wKc6xLCcehHW2C0cBQonR
xAHQN3iv44v/Y7YGEaD4Jhs+Jq/H7jgYQGhwINXjJdjQZF8AxAjPKWpNEMxieHdS
NY0VGvEqPXX23jmHQ9xhMDIgJavETNlUTcatQBuS2qLmUrs++Nn+
-----END RSA PRIVATE KEY-----
'@

mkdir c:\chef
set-content 'c:\chef\validation.pem' $pem

$client = @"
chef_server_url 'https://10.71.144.13'
node_name "$(hostname)"
"@

set-content 'c:\chef\client.rb' $client

$webclient = New-Object System.Net.Webclient
$webclient.DownloadFile("https://opscode-omnitruck-release.s3.amazonaws.com/windows/2008r2/x86_64/chef-client-11.4.0-1.windows.msi","C:\chef-client-11.4.0-1.windows.msi");
start-process C:\chef-client-11.4.0-1.windows.msi /quiet -wait

cd c:\chef
c:\opscode\chef\bin\chef-client
