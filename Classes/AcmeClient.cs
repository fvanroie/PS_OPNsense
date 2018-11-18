using System;
using System.Management.Automation;

namespace OPNsense.AcmeClient.accounts {
	public class Account {
		#region Parameters
		public PSObject certificateAuthority { get; set; }
		public string description { get; set; }
		public string email { get; set; }
		public bool enabled { get; set; }
		public string id { get; set; }
		public string key { get; set; }
		public int lastUpdate { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public Account () {
			certificateAuthority = null;
			description = null;
			email = null;
			enabled = true;
			id = null;
			key = null;
			lastUpdate = 0;
			name = null;
		}

		public Account (
			PSObject CertificateAuthority,
			string Description,
			string Email,
			byte Enabled,
			string Id,
			string Key,
			int LastUpdate,
			string Name
		) {
			certificateAuthority = CertificateAuthority;
			description = Description;
			email = Email;
			enabled = (Enabled == 0) ? false : true;
			id = Id;
			key = Key;
			lastUpdate = LastUpdate;
			name = Name;
		}
	}
}
namespace OPNsense.AcmeClient.actions {
	public class Action {
		#region Parameters
		public PSObject configd { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string id { get; set; }
		public string name { get; set; }
		public PSObject type { get; set; }
		#endregion Parameters

		public Action () {
			configd = null;
			description = null;
			enabled = true;
			id = null;
			name = null;
			type = null;
		}

		public Action (
			PSObject Configd,
			string Description,
			byte Enabled,
			string Id,
			string Name,
			PSObject Type
		) {
			configd = Configd;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			id = Id;
			name = Name;
			type = Type;
		}
	}
}
namespace OPNsense.AcmeClient.certificates {
	public class Certificate {
		#region Parameters
		public PSObject account { get; set; }
		public Object altNames { get; set; }
		public bool autoRenewal { get; set; }
		public string certRefId { get; set; }
		public string description { get; set; }
		public bool enabled { get; set; }
		public string id { get; set; }
		public PSObject keyLength { get; set; }
		public int lastUpdate { get; set; }
		public string name { get; set; }
		public bool ocsp { get; set; }
		public byte renewInterval { get; set; }
		public PSObject restartActions { get; set; }
		public ushort statusCode { get; set; }
		public int statusLastUpdate { get; set; }
		public PSObject validationMethod { get; set; }
		#endregion Parameters

		public Certificate () {
			account = null;
			altNames = null;
			autoRenewal = true;
			certRefId = null;
			description = null;
			enabled = true;
			id = null;
			keyLength = null;
			lastUpdate = 0;
			name = null;
			ocsp = true;
			renewInterval = 60;
			restartActions = null;
			statusCode = 0;
			statusLastUpdate = 0;
			validationMethod = null;
		}

		public Certificate (
			PSObject Account,
			Object AltNames,
			byte AutoRenewal,
			string CertRefId,
			string Description,
			byte Enabled,
			string Id,
			PSObject KeyLength,
			int LastUpdate,
			string Name,
			byte Ocsp,
			byte RenewInterval,
			PSObject RestartActions,
			ushort StatusCode,
			int StatusLastUpdate,
			PSObject ValidationMethod
		) {
			account = Account;
			altNames = AltNames;
			autoRenewal = (AutoRenewal == 0) ? false : true;
			certRefId = CertRefId;
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			id = Id;
			keyLength = KeyLength;
			lastUpdate = LastUpdate;
			name = Name;
			ocsp = (Ocsp == 0) ? false : true;
			renewInterval = RenewInterval;
			restartActions = RestartActions;
			statusCode = StatusCode;
			statusLastUpdate = StatusLastUpdate;
			validationMethod = ValidationMethod;
		}
	}
}
namespace OPNsense.AcmeClient.validations {
	public class Validation {
		#region Parameters
		public string description { get; set; }
		public string dns_ad_key { get; set; }
		public string dns_ali_key { get; set; }
		public string dns_ali_secret { get; set; }
		public string dns_autodns_context { get; set; }
		public string dns_autodns_password { get; set; }
		public string dns_autodns_user { get; set; }
		public string dns_aws_id { get; set; }
		public string dns_aws_secret { get; set; }
		public string dns_azuredns_appid { get; set; }
		public string dns_azuredns_clientsecret { get; set; }
		public string dns_azuredns_subscriptionid { get; set; }
		public string dns_azuredns_tenantid { get; set; }
		public string dns_cf_email { get; set; }
		public string dns_cf_key { get; set; }
		public string dns_cloudns_auth_id { get; set; }
		public string dns_cloudns_auth_password { get; set; }
		public string dns_cloudns_sub_auth_id { get; set; }
		public string dns_cx_key { get; set; }
		public string dns_cx_secret { get; set; }
		public string dns_cyon_password { get; set; }
		public string dns_cyon_user { get; set; }
		public bool dns_da_insecure { get; set; }
		public string dns_da_key { get; set; }
		public string dns_dgon_key { get; set; }
		public string dns_dh_key { get; set; }
		public string dns_dnsimple_token { get; set; }
		public string dns_do_password { get; set; }
		public string dns_do_pid { get; set; }
		public string dns_dp_id { get; set; }
		public string dns_dp_key { get; set; }
		public string dns_duckdns_token { get; set; }
		public string dns_dynu_clientid { get; set; }
		public string dns_dynu_secret { get; set; }
		public string dns_dyn_customer { get; set; }
		public string dns_dyn_password { get; set; }
		public string dns_dyn_user { get; set; }
		public string dns_freedns_password { get; set; }
		public string dns_freedns_user { get; set; }
		public string dns_gandi_livedns_key { get; set; }
		public string dns_gd_key { get; set; }
		public string dns_gd_secret { get; set; }
		public string dns_he_password { get; set; }
		public string dns_he_user { get; set; }
		public string dns_infoblox_credentials { get; set; }
		public string dns_infoblox_server { get; set; }
		public string dns_inws_password { get; set; }
		public string dns_inwx_user { get; set; }
		public string dns_ispconfig_api { get; set; }
		public bool dns_ispconfig_insecure { get; set; }
		public string dns_ispconfig_password { get; set; }
		public string dns_ispconfig_user { get; set; }
		public string dns_kinghost_password { get; set; }
		public string dns_kinghost_username { get; set; }
		public string dns_knot_key { get; set; }
		public string dns_knot_server { get; set; }
		public PSObject dns_lexicon_provider { get; set; }
		public string dns_lexicon_token { get; set; }
		public string dns_lexicon_user { get; set; }
		public string dns_linode_key { get; set; }
		public string dns_lua_email { get; set; }
		public string dns_lua_key { get; set; }
		public string dns_me_key { get; set; }
		public string dns_me_secret { get; set; }
		public string dns_namecom_token { get; set; }
		public string dns_namecom_user { get; set; }
		public string dns_namesilo_key { get; set; }
		public string dns_nsone_key { get; set; }
		public string dns_nsupdate_key { get; set; }
		public string dns_nsupdate_server { get; set; }
		public string dns_ovh_app_key { get; set; }
		public string dns_ovh_app_secret { get; set; }
		public string dns_ovh_consumer_key { get; set; }
		public string dns_ovh_endpoint { get; set; }
		public string dns_pdns_serverid { get; set; }
		public string dns_pdns_token { get; set; }
		public string dns_pdns_url { get; set; }
		public string dns_servercow_password { get; set; }
		public string dns_servercow_username { get; set; }
		public PSObject dns_service { get; set; }
		public ushort dns_sleep { get; set; }
		public string dns_sl_key { get; set; }
		public string dns_uno_key { get; set; }
		public string dns_uno_user { get; set; }
		public string dns_vscale_key { get; set; }
		public string dns_yandex_token { get; set; }
		public string dns_zilore_key { get; set; }
		public string dns_zm_key { get; set; }
		public bool enabled { get; set; }
		public PSObject http_haproxyFrontends { get; set; }
		public bool http_haproxyInject { get; set; }
		public bool http_opn_autodiscovery { get; set; }
		public PSObject http_opn_interface { get; set; }
		public Object http_opn_ipaddresses { get; set; }
		public PSObject http_service { get; set; }
		public string id { get; set; }
		public PSObject method { get; set; }
		public string name { get; set; }
		#endregion Parameters

		public Validation () {
			description = null;
			dns_ad_key = null;
			dns_ali_key = null;
			dns_ali_secret = null;
			dns_autodns_context = null;
			dns_autodns_password = null;
			dns_autodns_user = null;
			dns_aws_id = null;
			dns_aws_secret = null;
			dns_azuredns_appid = null;
			dns_azuredns_clientsecret = null;
			dns_azuredns_subscriptionid = null;
			dns_azuredns_tenantid = null;
			dns_cf_email = null;
			dns_cf_key = null;
			dns_cloudns_auth_id = null;
			dns_cloudns_auth_password = null;
			dns_cloudns_sub_auth_id = null;
			dns_cx_key = null;
			dns_cx_secret = null;
			dns_cyon_password = null;
			dns_cyon_user = null;
			dns_da_insecure = true;
			dns_da_key = null;
			dns_dgon_key = null;
			dns_dh_key = null;
			dns_dnsimple_token = null;
			dns_do_password = null;
			dns_do_pid = null;
			dns_dp_id = null;
			dns_dp_key = null;
			dns_duckdns_token = null;
			dns_dynu_clientid = null;
			dns_dynu_secret = null;
			dns_dyn_customer = null;
			dns_dyn_password = null;
			dns_dyn_user = null;
			dns_freedns_password = null;
			dns_freedns_user = null;
			dns_gandi_livedns_key = null;
			dns_gd_key = null;
			dns_gd_secret = null;
			dns_he_password = null;
			dns_he_user = null;
			dns_infoblox_credentials = null;
			dns_infoblox_server = null;
			dns_inws_password = null;
			dns_inwx_user = null;
			dns_ispconfig_api = null;
			dns_ispconfig_insecure = true;
			dns_ispconfig_password = null;
			dns_ispconfig_user = null;
			dns_kinghost_password = null;
			dns_kinghost_username = null;
			dns_knot_key = null;
			dns_knot_server = null;
			dns_lexicon_provider = null;
			dns_lexicon_token = null;
			dns_lexicon_user = null;
			dns_linode_key = null;
			dns_lua_email = null;
			dns_lua_key = null;
			dns_me_key = null;
			dns_me_secret = null;
			dns_namecom_token = null;
			dns_namecom_user = null;
			dns_namesilo_key = null;
			dns_nsone_key = null;
			dns_nsupdate_key = null;
			dns_nsupdate_server = null;
			dns_ovh_app_key = null;
			dns_ovh_app_secret = null;
			dns_ovh_consumer_key = null;
			dns_ovh_endpoint = null;
			dns_pdns_serverid = null;
			dns_pdns_token = null;
			dns_pdns_url = null;
			dns_servercow_password = null;
			dns_servercow_username = null;
			dns_service = null;
			dns_sleep = 120;
			dns_sl_key = null;
			dns_uno_key = null;
			dns_uno_user = null;
			dns_vscale_key = null;
			dns_yandex_token = null;
			dns_zilore_key = null;
			dns_zm_key = null;
			enabled = true;
			http_haproxyFrontends = null;
			http_haproxyInject = true;
			http_opn_autodiscovery = true;
			http_opn_interface = null;
			http_opn_ipaddresses = null;
			http_service = null;
			id = null;
			method = null;
			name = null;
		}

		public Validation (
			string Description,
			string Dns_Ad_Key,
			string Dns_Ali_Key,
			string Dns_Ali_Secret,
			string Dns_Autodns_Context,
			string Dns_Autodns_Password,
			string Dns_Autodns_User,
			string Dns_Aws_Id,
			string Dns_Aws_Secret,
			string Dns_Azuredns_Appid,
			string Dns_Azuredns_Clientsecret,
			string Dns_Azuredns_Subscriptionid,
			string Dns_Azuredns_Tenantid,
			string Dns_Cf_Email,
			string Dns_Cf_Key,
			string Dns_Cloudns_Auth_Id,
			string Dns_Cloudns_Auth_Password,
			string Dns_Cloudns_Sub_Auth_Id,
			string Dns_Cx_Key,
			string Dns_Cx_Secret,
			string Dns_Cyon_Password,
			string Dns_Cyon_User,
			byte Dns_Da_Insecure,
			string Dns_Da_Key,
			string Dns_Dgon_Key,
			string Dns_Dh_Key,
			string Dns_Dnsimple_Token,
			string Dns_Do_Password,
			string Dns_Do_Pid,
			string Dns_Dp_Id,
			string Dns_Dp_Key,
			string Dns_Duckdns_Token,
			string Dns_Dynu_Clientid,
			string Dns_Dynu_Secret,
			string Dns_Dyn_Customer,
			string Dns_Dyn_Password,
			string Dns_Dyn_User,
			string Dns_Freedns_Password,
			string Dns_Freedns_User,
			string Dns_Gandi_Livedns_Key,
			string Dns_Gd_Key,
			string Dns_Gd_Secret,
			string Dns_He_Password,
			string Dns_He_User,
			string Dns_Infoblox_Credentials,
			string Dns_Infoblox_Server,
			string Dns_Inws_Password,
			string Dns_Inwx_User,
			string Dns_Ispconfig_Api,
			byte Dns_Ispconfig_Insecure,
			string Dns_Ispconfig_Password,
			string Dns_Ispconfig_User,
			string Dns_Kinghost_Password,
			string Dns_Kinghost_Username,
			string Dns_Knot_Key,
			string Dns_Knot_Server,
			PSObject Dns_Lexicon_Provider,
			string Dns_Lexicon_Token,
			string Dns_Lexicon_User,
			string Dns_Linode_Key,
			string Dns_Lua_Email,
			string Dns_Lua_Key,
			string Dns_Me_Key,
			string Dns_Me_Secret,
			string Dns_Namecom_Token,
			string Dns_Namecom_User,
			string Dns_Namesilo_Key,
			string Dns_Nsone_Key,
			string Dns_Nsupdate_Key,
			string Dns_Nsupdate_Server,
			string Dns_Ovh_App_Key,
			string Dns_Ovh_App_Secret,
			string Dns_Ovh_Consumer_Key,
			string Dns_Ovh_Endpoint,
			string Dns_Pdns_Serverid,
			string Dns_Pdns_Token,
			string Dns_Pdns_Url,
			string Dns_Servercow_Password,
			string Dns_Servercow_Username,
			PSObject Dns_Service,
			ushort Dns_Sleep,
			string Dns_Sl_Key,
			string Dns_Uno_Key,
			string Dns_Uno_User,
			string Dns_Vscale_Key,
			string Dns_Yandex_Token,
			string Dns_Zilore_Key,
			string Dns_Zm_Key,
			byte Enabled,
			PSObject Http_HaproxyFrontends,
			byte Http_HaproxyInject,
			byte Http_Opn_Autodiscovery,
			PSObject Http_Opn_Interface,
			Object Http_Opn_Ipaddresses,
			PSObject Http_Service,
			string Id,
			PSObject Method,
			string Name
		) {
			description = Description;
			dns_ad_key = Dns_Ad_Key;
			dns_ali_key = Dns_Ali_Key;
			dns_ali_secret = Dns_Ali_Secret;
			dns_autodns_context = Dns_Autodns_Context;
			dns_autodns_password = Dns_Autodns_Password;
			dns_autodns_user = Dns_Autodns_User;
			dns_aws_id = Dns_Aws_Id;
			dns_aws_secret = Dns_Aws_Secret;
			dns_azuredns_appid = Dns_Azuredns_Appid;
			dns_azuredns_clientsecret = Dns_Azuredns_Clientsecret;
			dns_azuredns_subscriptionid = Dns_Azuredns_Subscriptionid;
			dns_azuredns_tenantid = Dns_Azuredns_Tenantid;
			dns_cf_email = Dns_Cf_Email;
			dns_cf_key = Dns_Cf_Key;
			dns_cloudns_auth_id = Dns_Cloudns_Auth_Id;
			dns_cloudns_auth_password = Dns_Cloudns_Auth_Password;
			dns_cloudns_sub_auth_id = Dns_Cloudns_Sub_Auth_Id;
			dns_cx_key = Dns_Cx_Key;
			dns_cx_secret = Dns_Cx_Secret;
			dns_cyon_password = Dns_Cyon_Password;
			dns_cyon_user = Dns_Cyon_User;
			dns_da_insecure = (Dns_Da_Insecure == 0) ? false : true;
			dns_da_key = Dns_Da_Key;
			dns_dgon_key = Dns_Dgon_Key;
			dns_dh_key = Dns_Dh_Key;
			dns_dnsimple_token = Dns_Dnsimple_Token;
			dns_do_password = Dns_Do_Password;
			dns_do_pid = Dns_Do_Pid;
			dns_dp_id = Dns_Dp_Id;
			dns_dp_key = Dns_Dp_Key;
			dns_duckdns_token = Dns_Duckdns_Token;
			dns_dynu_clientid = Dns_Dynu_Clientid;
			dns_dynu_secret = Dns_Dynu_Secret;
			dns_dyn_customer = Dns_Dyn_Customer;
			dns_dyn_password = Dns_Dyn_Password;
			dns_dyn_user = Dns_Dyn_User;
			dns_freedns_password = Dns_Freedns_Password;
			dns_freedns_user = Dns_Freedns_User;
			dns_gandi_livedns_key = Dns_Gandi_Livedns_Key;
			dns_gd_key = Dns_Gd_Key;
			dns_gd_secret = Dns_Gd_Secret;
			dns_he_password = Dns_He_Password;
			dns_he_user = Dns_He_User;
			dns_infoblox_credentials = Dns_Infoblox_Credentials;
			dns_infoblox_server = Dns_Infoblox_Server;
			dns_inws_password = Dns_Inws_Password;
			dns_inwx_user = Dns_Inwx_User;
			dns_ispconfig_api = Dns_Ispconfig_Api;
			dns_ispconfig_insecure = (Dns_Ispconfig_Insecure == 0) ? false : true;
			dns_ispconfig_password = Dns_Ispconfig_Password;
			dns_ispconfig_user = Dns_Ispconfig_User;
			dns_kinghost_password = Dns_Kinghost_Password;
			dns_kinghost_username = Dns_Kinghost_Username;
			dns_knot_key = Dns_Knot_Key;
			dns_knot_server = Dns_Knot_Server;
			dns_lexicon_provider = Dns_Lexicon_Provider;
			dns_lexicon_token = Dns_Lexicon_Token;
			dns_lexicon_user = Dns_Lexicon_User;
			dns_linode_key = Dns_Linode_Key;
			dns_lua_email = Dns_Lua_Email;
			dns_lua_key = Dns_Lua_Key;
			dns_me_key = Dns_Me_Key;
			dns_me_secret = Dns_Me_Secret;
			dns_namecom_token = Dns_Namecom_Token;
			dns_namecom_user = Dns_Namecom_User;
			dns_namesilo_key = Dns_Namesilo_Key;
			dns_nsone_key = Dns_Nsone_Key;
			dns_nsupdate_key = Dns_Nsupdate_Key;
			dns_nsupdate_server = Dns_Nsupdate_Server;
			dns_ovh_app_key = Dns_Ovh_App_Key;
			dns_ovh_app_secret = Dns_Ovh_App_Secret;
			dns_ovh_consumer_key = Dns_Ovh_Consumer_Key;
			dns_ovh_endpoint = Dns_Ovh_Endpoint;
			dns_pdns_serverid = Dns_Pdns_Serverid;
			dns_pdns_token = Dns_Pdns_Token;
			dns_pdns_url = Dns_Pdns_Url;
			dns_servercow_password = Dns_Servercow_Password;
			dns_servercow_username = Dns_Servercow_Username;
			dns_service = Dns_Service;
			dns_sleep = Dns_Sleep;
			dns_sl_key = Dns_Sl_Key;
			dns_uno_key = Dns_Uno_Key;
			dns_uno_user = Dns_Uno_User;
			dns_vscale_key = Dns_Vscale_Key;
			dns_yandex_token = Dns_Yandex_Token;
			dns_zilore_key = Dns_Zilore_Key;
			dns_zm_key = Dns_Zm_Key;
			enabled = (Enabled == 0) ? false : true;
			http_haproxyFrontends = Http_HaproxyFrontends;
			http_haproxyInject = (Http_HaproxyInject == 0) ? false : true;
			http_opn_autodiscovery = (Http_Opn_Autodiscovery == 0) ? false : true;
			http_opn_interface = Http_Opn_Interface;
			http_opn_ipaddresses = Http_Opn_Ipaddresses;
			http_service = Http_Service;
			id = Id;
			method = Method;
			name = Name;
		}
	}
}
namespace OPNsense.AcmeClient {
	public class Settings {
		#region Parameters
		public bool autoRenewal { get; set; }
		public ushort challengePort { get; set; }
		public bool enabled { get; set; }
		public PSObject environment { get; set; }
		public PSObject haproxyAclRef { get; set; }
		public PSObject haproxyActionRef { get; set; }
		public PSObject haproxyBackendRef { get; set; }
		public bool haproxyIntegration { get; set; }
		public PSObject haproxyServerRef { get; set; }
		public PSObject logLevel { get; set; }
		public uint restartTimeout { get; set; }
		public PSObject UpdateCron { get; set; }
		#endregion Parameters

		public Settings () {
			autoRenewal = true;
			challengePort = 43580;
			enabled = true;
			environment = null;
			haproxyAclRef = null;
			haproxyActionRef = null;
			haproxyBackendRef = null;
			haproxyIntegration = true;
			haproxyServerRef = null;
			logLevel = null;
			restartTimeout = 600;
			UpdateCron = null;
		}

		public Settings (
			byte AutoRenewal,
			ushort ChallengePort,
			byte Enabled,
			PSObject Environment,
			PSObject HaproxyAclRef,
			PSObject HaproxyActionRef,
			PSObject HaproxyBackendRef,
			byte HaproxyIntegration,
			PSObject HaproxyServerRef,
			PSObject LogLevel,
			uint RestartTimeout,
			PSObject updatecron
		) {
			autoRenewal = (AutoRenewal == 0) ? false : true;
			challengePort = ChallengePort;
			enabled = (Enabled == 0) ? false : true;
			environment = Environment;
			haproxyAclRef = HaproxyAclRef;
			haproxyActionRef = HaproxyActionRef;
			haproxyBackendRef = HaproxyBackendRef;
			haproxyIntegration = (HaproxyIntegration == 0) ? false : true;
			haproxyServerRef = HaproxyServerRef;
			logLevel = LogLevel;
			restartTimeout = RestartTimeout;
			UpdateCron = updatecron;
		}
	}
}
