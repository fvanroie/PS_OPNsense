using System;
using System.Management.Automation;

namespace OPNsense.Nginx {
	public class Credential {
		#region Parameters
		public string password { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public Credential () {
			password = null;
			username = null;
		}

		public Credential (
			string Password,
			string Username
		) {
			password = Password;
			username = Username;
		}
	}
}
namespace OPNsense.Nginx {
	public class Custom_Policy {
		#region Parameters
		public PSObject action { get; set; }
		public string name { get; set; }
		public PSObject naxsi_rules { get; set; }
		public PSObject Operator { get; set; }
		public int value { get; set; }
		#endregion Parameters

		public Custom_Policy () {
			action = null;
			name = null;
			naxsi_rules = null;
			Operator = null;
			value = 0;
		}

		public Custom_Policy (
			PSObject Action,
			string Name,
			PSObject Naxsi_Rules,
			PSObject Operator_,
			int Value
		) {
			action = Action;
			name = Name;
			naxsi_rules = Naxsi_Rules;
			Operator = Operator_;
			value = Value;
		}
	}
}
namespace OPNsense.Nginx {
	public class Http_Server {
		#region Parameters
		public PSObject access_log_format { get; set; }
		public bool block_nonpublic_data { get; set; }
		public PSObject ca { get; set; }
		public PSObject certificate { get; set; }
		public PSObject charset { get; set; }
		public bool enable_acme_support { get; set; }
		public bool https_only { get; set; }
		public PSObject limit_request_connections { get; set; }
		public PSObject listen_https_port { get; set; }
		public PSObject listen_http_port { get; set; }
		public PSObject locations { get; set; }
		public bool naxsi_extensive_log { get; set; }
		public PSObject rewrites { get; set; }
		public string root { get; set; }
		public PSObject security_header { get; set; }
		public bool sendfile { get; set; }
		public Object servername { get; set; }
		public PSObject verify_client { get; set; }
		#endregion Parameters

		public Http_Server () {
			access_log_format = null;
			block_nonpublic_data = true;
			ca = null;
			certificate = null;
			charset = null;
			enable_acme_support = true;
			https_only = true;
			limit_request_connections = null;
			listen_https_port = null;
			listen_http_port = null;
			locations = null;
			naxsi_extensive_log = true;
			rewrites = null;
			root = null;
			security_header = null;
			sendfile = true;
			servername = null;
			verify_client = null;
		}

		public Http_Server (
			PSObject Access_Log_Format,
			byte Block_Nonpublic_Data,
			PSObject Ca,
			PSObject Certificate,
			PSObject Charset,
			byte Enable_Acme_Support,
			byte Https_Only,
			PSObject Limit_Request_Connections,
			PSObject Listen_Https_Port,
			PSObject Listen_Http_Port,
			PSObject Locations,
			byte Naxsi_Extensive_Log,
			PSObject Rewrites,
			string Root,
			PSObject Security_Header,
			byte Sendfile,
			Object Servername,
			PSObject Verify_Client
		) {
			access_log_format = Access_Log_Format;
			block_nonpublic_data = (Block_Nonpublic_Data == 0) ? false : true;
			ca = Ca;
			certificate = Certificate;
			charset = Charset;
			enable_acme_support = (Enable_Acme_Support == 0) ? false : true;
			https_only = (Https_Only == 0) ? false : true;
			limit_request_connections = Limit_Request_Connections;
			listen_https_port = Listen_Https_Port;
			listen_http_port = Listen_Http_Port;
			locations = Locations;
			naxsi_extensive_log = (Naxsi_Extensive_Log == 0) ? false : true;
			rewrites = Rewrites;
			root = Root;
			security_header = Security_Header;
			sendfile = (Sendfile == 0) ? false : true;
			servername = Servername;
			verify_client = Verify_Client;
		}
	}
}
namespace OPNsense.Nginx {
	public class Location {
		#region Parameters
		public bool advanced_acl { get; set; }
		public string authbasic { get; set; }
		public PSObject authbasicuserfile { get; set; }
		public bool autoindex { get; set; }
		public bool cache_background_update { get; set; }
		public bool cache_lock { get; set; }
		public PSObject cache_methods { get; set; }
		public int cache_min_uses { get; set; }
		public PSObject cache_path { get; set; }
		public bool cache_revalidate { get; set; }
		public PSObject cache_use_stale { get; set; }
		public PSObject custom_policy { get; set; }
		public string description { get; set; }
		public bool enable_learning_mode { get; set; }
		public bool enable_secrules { get; set; }
		public string force_https { get; set; }
		public bool honeypot { get; set; }
		public bool http2_push_preload { get; set; }
		public Object index { get; set; }
		public PSObject limit_request_connections { get; set; }
		public PSObject matchtype { get; set; }
		public string path_prefix { get; set; }
		public bool php_enable { get; set; }
		public string php_override_scriptname { get; set; }
		public PSObject rewrites { get; set; }
		public string root { get; set; }
		public int sqli_block_score { get; set; }
		public PSObject upstream { get; set; }
		public string urlpattern { get; set; }
		public bool websocket { get; set; }
		public int xss_block_score { get; set; }
		#endregion Parameters

		public Location () {
			advanced_acl = true;
			authbasic = null;
			authbasicuserfile = null;
			autoindex = false;
			cache_background_update = true;
			cache_lock = true;
			cache_methods = null;
			cache_min_uses = 1;
			cache_path = null;
			cache_revalidate = true;
			cache_use_stale = null;
			custom_policy = null;
			description = null;
			enable_learning_mode = true;
			enable_secrules = true;
			force_https = null;
			honeypot = true;
			http2_push_preload = true;
			index = null;
			limit_request_connections = null;
			matchtype = null;
			path_prefix = null;
			php_enable = true;
			php_override_scriptname = null;
			rewrites = null;
			root = null;
			sqli_block_score = 0;
			upstream = null;
			urlpattern = null;
			websocket = true;
			xss_block_score = 0;
		}

		public Location (
			byte Advanced_Acl,
			string Authbasic,
			PSObject Authbasicuserfile,
			byte Autoindex,
			byte Cache_Background_Update,
			byte Cache_Lock,
			PSObject Cache_Methods,
			int Cache_Min_Uses,
			PSObject Cache_Path,
			byte Cache_Revalidate,
			PSObject Cache_Use_Stale,
			PSObject Custom_Policy,
			string Description,
			byte Enable_Learning_Mode,
			byte Enable_Secrules,
			string Force_Https,
			byte Honeypot,
			byte Http2_Push_Preload,
			Object Index,
			PSObject Limit_Request_Connections,
			PSObject Matchtype,
			string Path_Prefix,
			byte Php_Enable,
			string Php_Override_Scriptname,
			PSObject Rewrites,
			string Root,
			int Sqli_Block_Score,
			PSObject Upstream,
			string Urlpattern,
			byte Websocket,
			int Xss_Block_Score
		) {
			advanced_acl = (Advanced_Acl == 0) ? false : true;
			authbasic = Authbasic;
			authbasicuserfile = Authbasicuserfile;
			autoindex = (Autoindex == 0) ? false : true;
			cache_background_update = (Cache_Background_Update == 0) ? false : true;
			cache_lock = (Cache_Lock == 0) ? false : true;
			cache_methods = Cache_Methods;
			cache_min_uses = Cache_Min_Uses;
			cache_path = Cache_Path;
			cache_revalidate = (Cache_Revalidate == 0) ? false : true;
			cache_use_stale = Cache_Use_Stale;
			custom_policy = Custom_Policy;
			description = Description;
			enable_learning_mode = (Enable_Learning_Mode == 0) ? false : true;
			enable_secrules = (Enable_Secrules == 0) ? false : true;
			force_https = Force_Https;
			honeypot = (Honeypot == 0) ? false : true;
			http2_push_preload = (Http2_Push_Preload == 0) ? false : true;
			index = Index;
			limit_request_connections = Limit_Request_Connections;
			matchtype = Matchtype;
			path_prefix = Path_Prefix;
			php_enable = (Php_Enable == 0) ? false : true;
			php_override_scriptname = Php_Override_Scriptname;
			rewrites = Rewrites;
			root = Root;
			sqli_block_score = Sqli_Block_Score;
			upstream = Upstream;
			urlpattern = Urlpattern;
			websocket = (Websocket == 0) ? false : true;
			xss_block_score = Xss_Block_Score;
		}
	}
}
namespace OPNsense.Nginx {
	public class Naxsi_Rule {
		#region Parameters
		public bool args { get; set; }
		public string description { get; set; }
		public string dollar_args_var { get; set; }
		public string dollar_body_var { get; set; }
		public string dollar_headers_var { get; set; }
		public string dollar_url { get; set; }
		public bool file_extension { get; set; }
		public bool headers { get; set; }
		public int identifier { get; set; }
		public PSObject match_type { get; set; }
		public string match_value { get; set; }
		public string message { get; set; }
		public bool name { get; set; }
		public bool negate { get; set; }
		public bool raw_body { get; set; }
		public bool regex { get; set; }
		public PSObject ruletype { get; set; }
		public int score { get; set; }
		public string url { get; set; }
		#endregion Parameters

		public Naxsi_Rule () {
			args = false;
			description = null;
			dollar_args_var = null;
			dollar_body_var = null;
			dollar_headers_var = null;
			dollar_url = null;
			file_extension = false;
			headers = false;
			identifier = 0;
			match_type = null;
			match_value = null;
			message = null;
			name = false;
			negate = false;
			raw_body = false;
			regex = false;
			ruletype = null;
			score = 8;
			url = null;
		}

		public Naxsi_Rule (
			byte Args,
			string Description,
			string Dollar_Args_Var,
			string Dollar_Body_Var,
			string Dollar_Headers_Var,
			string Dollar_Url,
			byte File_Extension,
			byte Headers,
			int Identifier,
			PSObject Match_Type,
			string Match_Value,
			string Message,
			byte Name,
			byte Negate,
			byte Raw_Body,
			byte Regex,
			PSObject Ruletype,
			int Score,
			string Url
		) {
			args = (Args == 0) ? false : true;
			description = Description;
			dollar_args_var = Dollar_Args_Var;
			dollar_body_var = Dollar_Body_Var;
			dollar_headers_var = Dollar_Headers_Var;
			dollar_url = Dollar_Url;
			file_extension = (File_Extension == 0) ? false : true;
			headers = (Headers == 0) ? false : true;
			identifier = Identifier;
			match_type = Match_Type;
			match_value = Match_Value;
			message = Message;
			name = (Name == 0) ? false : true;
			negate = (Negate == 0) ? false : true;
			raw_body = (Raw_Body == 0) ? false : true;
			regex = (Regex == 0) ? false : true;
			ruletype = Ruletype;
			score = Score;
			url = Url;
		}
	}
}
namespace OPNsense.Nginx {
	public class Upstream {
		#region Parameters
		public string description { get; set; }
		public PSObject serverentries { get; set; }
		public bool store { get; set; }
		public PSObject tls_client_certificate { get; set; }
		public bool tls_enable { get; set; }
		public string tls_name_override { get; set; }
		public PSObject tls_protocol_versions { get; set; }
		public bool tls_session_reuse { get; set; }
		public PSObject tls_trusted_certificate { get; set; }
		public bool tls_verify { get; set; }
		public uint tls_verify_depth { get; set; }
		#endregion Parameters

		public Upstream () {
			description = null;
			serverentries = null;
			store = true;
			tls_client_certificate = null;
			tls_enable = true;
			tls_name_override = null;
			tls_protocol_versions = null;
			tls_session_reuse = true;
			tls_trusted_certificate = null;
			tls_verify = true;
			tls_verify_depth = 1;
		}

		public Upstream (
			string Description,
			PSObject Serverentries,
			byte Store,
			PSObject Tls_Client_Certificate,
			byte Tls_Enable,
			string Tls_Name_Override,
			PSObject Tls_Protocol_Versions,
			byte Tls_Session_Reuse,
			PSObject Tls_Trusted_Certificate,
			byte Tls_Verify,
			uint Tls_Verify_Depth
		) {
			description = Description;
			serverentries = Serverentries;
			store = (Store == 0) ? false : true;
			tls_client_certificate = Tls_Client_Certificate;
			tls_enable = (Tls_Enable == 0) ? false : true;
			tls_name_override = Tls_Name_Override;
			tls_protocol_versions = Tls_Protocol_Versions;
			tls_session_reuse = (Tls_Session_Reuse == 0) ? false : true;
			tls_trusted_certificate = Tls_Trusted_Certificate;
			tls_verify = (Tls_Verify == 0) ? false : true;
			tls_verify_depth = Tls_Verify_Depth;
		}
	}
}
namespace OPNsense.Nginx {
	public class Upstreamserver {
		#region Parameters
		#endregion Parameters

		public Upstreamserver () {
		}

	}
}
namespace OPNsense.Nginx {
	public class Userlist {
		#region Parameters
		public string name { get; set; }
		public PSObject users { get; set; }
		#endregion Parameters

		public Userlist () {
			name = null;
			users = null;
		}

		public Userlist (
			string Name,
			PSObject Users
		) {
			name = Name;
			users = Users;
		}
	}
}
