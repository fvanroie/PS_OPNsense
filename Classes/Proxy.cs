using System;
using System.Management.Automation;

namespace OPNsense.proxy.pac {
	public class Match {
		#region Parameters
		public PSObject date_from { get; set; }
		public PSObject date_to { get; set; }
		public string description { get; set; }
		public uint domain_level_from { get; set; }
		public uint domain_level_to { get; set; }
		public string hostname { get; set; }
		public PSObject match_type { get; set; }
		public string name { get; set; }
		public bool negate { get; set; }
		public PSObject network { get; set; }
		public uint time_from { get; set; }
		public uint time_to { get; set; }
		public string url { get; set; }
		public PSObject weekday_from { get; set; }
		public PSObject weekday_to { get; set; }
		#endregion Parameters

		public Match () {
			date_from = null;
			date_to = null;
			description = null;
			domain_level_from = 0;
			domain_level_to = 0;
			hostname = null;
			match_type = null;
			name = null;
			negate = true;
			network = null;
			time_from = 0;
			time_to = 0;
			url = null;
			weekday_from = null;
			weekday_to = null;
		}

		public Match (
			PSObject Date_From,
			PSObject Date_To,
			string Description,
			uint Domain_Level_From,
			uint Domain_Level_To,
			string Hostname,
			PSObject Match_Type,
			string Name,
			byte Negate,
			PSObject Network,
			uint Time_From,
			uint Time_To,
			string Url,
			PSObject Weekday_From,
			PSObject Weekday_To
		) {
			date_from = Date_From;
			date_to = Date_To;
			description = Description;
			domain_level_from = Domain_Level_From;
			domain_level_to = Domain_Level_To;
			hostname = Hostname;
			match_type = Match_Type;
			name = Name;
			negate = (Negate == 0) ? false : true;
			network = Network;
			time_from = Time_From;
			time_to = Time_To;
			url = Url;
			weekday_from = Weekday_From;
			weekday_to = Weekday_To;
		}
	}
}
namespace OPNsense.proxy.pac {
	public class Proxy {
		#region Parameters
		public string description { get; set; }
		public string name { get; set; }
		public PSObject proxy_type { get; set; }
		public string url { get; set; }
		#endregion Parameters

		public Proxy () {
			description = null;
			name = null;
			proxy_type = null;
			url = null;
		}

		public Proxy (
			string Description,
			string Name,
			PSObject Proxy_Type,
			string Url
		) {
			description = Description;
			name = Name;
			proxy_type = Proxy_Type;
			url = Url;
		}
	}
}
namespace OPNsense.proxy.pac {
	public class Rule {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public PSObject join_type { get; set; }
		public PSObject matches { get; set; }
		public PSObject match_type { get; set; }
		public PSObject proxies { get; set; }
		#endregion Parameters

		public Rule () {
			description = null;
			enabled = true;
			join_type = null;
			matches = null;
			match_type = null;
			proxies = null;
		}

		public Rule (
			string Description,
			byte Enabled,
			PSObject Join_Type,
			PSObject Matches,
			PSObject Match_Type,
			PSObject Proxies
		) {
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			join_type = Join_Type;
			matches = Matches;
			match_type = Match_Type;
			proxies = Proxies;
		}
	}
}
namespace OPNsense.proxy.forward.acl.remoteACLs.blacklists {
	public class Blacklist {
		#region Parameters
		public string description { get; set; }
		public bool enabled { get; set; }
		public string filename { get; set; }
		public PSObject filter { get; set; }
		public string password { get; set; }
		public bool sslNoVerify { get; set; }
		public string url { get; set; }
		public string username { get; set; }
		#endregion Parameters

		public Blacklist () {
			description = null;
			enabled = true;
			filename = null;
			filter = null;
			password = null;
			sslNoVerify = true;
			url = null;
			username = null;
		}

		public Blacklist (
			string Description,
			byte Enabled,
			string Filename,
			PSObject Filter,
			string Password,
			byte SslNoVerify,
			string Url,
			string Username
		) {
			description = Description;
			enabled = (Enabled == 0) ? false : true;
			filename = Filename;
			filter = Filter;
			password = Password;
			sslNoVerify = (SslNoVerify == 0) ? false : true;
			url = Url;
			username = Username;
		}
	}
}
