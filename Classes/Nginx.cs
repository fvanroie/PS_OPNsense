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
		public PSObject listen_https_port { get; set; }
		public PSObject listen_http_port { get; set; }
		public PSObject locations { get; set; }
		public bool naxsi_extensive_log { get; set; }
		public PSObject rewrites { get; set; }
		public string root { get; set; }
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
			listen_https_port = null;
			listen_http_port = null;
			locations = null;
			naxsi_extensive_log = true;
			rewrites = null;
			root = null;
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
			PSObject Listen_Https_Port,
			PSObject Listen_Http_Port,
			PSObject Locations,
			byte Naxsi_Extensive_Log,
			PSObject Rewrites,
			string Root,
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
			listen_https_port = Listen_Https_Port;
			listen_http_port = Listen_Http_Port;
			locations = Locations;
			naxsi_extensive_log = (Naxsi_Extensive_Log == 0) ? false : true;
			rewrites = Rewrites;
			root = Root;
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
		public PSObject custom_policy { get; set; }
		public string description { get; set; }
		public bool enable_learning_mode { get; set; }
		public bool enable_secrules { get; set; }
		public string force_https { get; set; }
		public Object index { get; set; }
		public PSObject matchtype { get; set; }
		public PSObject rewrites { get; set; }
		public string root { get; set; }
		public int sqli_block_score { get; set; }
		public PSObject upstream { get; set; }
		public string urlpattern { get; set; }
		public int xss_block_score { get; set; }
		#endregion Parameters

		public Location () {
			advanced_acl = true;
			authbasic = null;
			authbasicuserfile = null;
			autoindex = false;
			custom_policy = null;
			description = null;
			enable_learning_mode = true;
			enable_secrules = true;
			force_https = null;
			index = null;
			matchtype = null;
			rewrites = null;
			root = null;
			sqli_block_score = 0;
			upstream = null;
			urlpattern = null;
			xss_block_score = 0;
		}

		public Location (
			byte Advanced_Acl,
			string Authbasic,
			PSObject Authbasicuserfile,
			byte Autoindex,
			PSObject Custom_Policy,
			string Description,
			byte Enable_Learning_Mode,
			byte Enable_Secrules,
			string Force_Https,
			Object Index,
			PSObject Matchtype,
			PSObject Rewrites,
			string Root,
			int Sqli_Block_Score,
			PSObject Upstream,
			string Urlpattern,
			int Xss_Block_Score
		) {
			advanced_acl = (Advanced_Acl == 0) ? false : true;
			authbasic = Authbasic;
			authbasicuserfile = Authbasicuserfile;
			autoindex = (Autoindex == 0) ? false : true;
			custom_policy = Custom_Policy;
			description = Description;
			enable_learning_mode = (Enable_Learning_Mode == 0) ? false : true;
			enable_secrules = (Enable_Secrules == 0) ? false : true;
			force_https = Force_Https;
			index = Index;
			matchtype = Matchtype;
			rewrites = Rewrites;
			root = Root;
			sqli_block_score = Sqli_Block_Score;
			upstream = Upstream;
			urlpattern = Urlpattern;
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
