using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// AccountSettings
/// 
/// Replace this class with an interface to your own applications account settings. 
/// 
/// Each account should as a minimum have the following:
///  - A URL pointing to the identity provider for sending Auth Requests
///  - A X.509 certificate for validating the SAML Responses from the identity provider
/// 
/// These should be retrieved from the account store/database on each request in the authentication flow.
/// </summary>
public class AccountSettings
{
    public string certificate = "-----BEGIN CERTIFICATE-----\nMIID9TCCAt2gAwIBAgIUdnkmC6hW+svkTzaoNW/CwQQv+/IwDQYJKoZIhvcNAQEF\nBQAwTTEYMBYGA1UECgwPTHluaWF0ZSBTYW5kYm94MRUwEwYDVQQLDAxPbmVMb2dp\nbiBJZFAxGjAYBgNVBAMMEU9uZUxvZ2luIEFjY291bnQgMB4XDTIxMDQwMTE2MTEw\nMloXDTI2MDQwMTE2MTEwMlowTTEYMBYGA1UECgwPTHluaWF0ZSBTYW5kYm94MRUw\nEwYDVQQLDAxPbmVMb2dpbiBJZFAxGjAYBgNVBAMMEU9uZUxvZ2luIEFjY291bnQg\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA24w16xYnPrBH+jXcI0dC\nleWE6UI7grmZhNxPNr/Gsa1CsvFsO07mTFT0OaP9yaqGCutsLFHFmQSe5WyzMbTq\nv8huRmcL3vp+2NhBsI/hAXypMJR7JQ9jI9I7vhRlMIf0HcrJQKe+OGvm/hn5e2ji\n+0/5LvrZFHzsP0xTdGqyFQ0LJaAHJ66XcX4OTW1Pmm26EnMAFmeGQLEERe+1Gc3Y\naVutfZU9YQBNvFOnf9vzLwPBCCDVkctPkAAH9Tgdg2XENJY9fnIkVlwtxwTXvLja\nuxP/8Qo4oMDaXStc78MCCvYzFe5kKQ0QOKpkyvmkR1/qhNFDL8NdLsmEaWcyactt\nEwIDAQABo4HMMIHJMAwGA1UdEwEB/wQCMAAwHQYDVR0OBBYEFIvfLI4u3uM12+d1\nhNOcYL+5rGKeMIGJBgNVHSMEgYEwf4AUi98sji7e4zXb53WE05xgv7msYp6hUaRP\nME0xGDAWBgNVBAoMD0x5bmlhdGUgU2FuZGJveDEVMBMGA1UECwwMT25lTG9naW4g\nSWRQMRowGAYDVQQDDBFPbmVMb2dpbiBBY2NvdW50IIIUdnkmC6hW+svkTzaoNW/C\nwQQv+/IwDgYDVR0PAQH/BAQDAgeAMA0GCSqGSIb3DQEBBQUAA4IBAQClhAoEXLwg\nkLw7EGK6v8HCpoi+MEP9epugo1nXDKlwN1N7VbSTp1fU14Ht7n6vv9E5whN1obzz\nMY+jb0ESJBD/0HYoqown8o5TFcmsVO1z37Un+gdQzouJnGzF5gIjZZgh+H8WzwPn\ni4JaUyHnhTkAh6frWsscU/2aLd44pYNkXP/IjDkepHi3xSI3oT4ZRUUQeNy4SivP\n6Sv0UHcQlpawAXs+7F1VurkJdqD4f/XGQkDE9yocpPI13cKxl+RkfQOPnWrolZig\npwAoho5wtF7msF+YrIInuSKRzDK0PiR1bpMXsG7B+8FJJKzRndSLlpkZmbe7WDWf\nSiHSGMg1lfxB\n-----END CERTIFICATE-----";
    public string idp_sso_target_url = "https://lyniate-sandbox.onelogin.com/trust/saml2/http-post/sso/860759b8-9c97-40ad-b5c2-0f1137da620f";
}
