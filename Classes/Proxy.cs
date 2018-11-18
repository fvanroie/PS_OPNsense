using System;
using System.Management.Automation;

namespace OPNsense.proxy.forward.acl {
	public class Remoteacls {
		#region Parameters
		public  UpdateCron { get; set; }
		#endregion Parameters

		public Remoteacls () {
			UpdateCron = ;
		}

		public Remoteacls (
			 updatecron
		) {
			UpdateCron = updatecron;
		}
	}
}
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
		public byte time_to { get; set; }
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
			byte Time_To,
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
namespace OPNsense.proxy.forward {
	public class Acl {
		#region Parameters
		public  allowedSubnets { get; set; }
		public  bannedHosts { get; set; }
		public  blackList { get; set; }
		public  browser { get; set; }
		public  mimeType { get; set; }
		public  safePorts { get; set; }
		public  sslPorts { get; set; }
		public  unrestricted { get; set; }
		public  whiteList { get; set; }
		#endregion Parameters

		public Acl () {
			allowedSubnets = ;
			bannedHosts = ;
			blackList = ;
			browser = ;
			mimeType = ;
			safePorts = ;
			sslPorts = ;
			unrestricted = ;
			whiteList = ;
		}

		public Acl (
			 AllowedSubnets,
			 BannedHosts,
			 BlackList,
			 Browser,
			 MimeType,
			 SafePorts,
			 SslPorts,
			 Unrestricted,
			 WhiteList
		) {
			allowedSubnets = AllowedSubnets;
			bannedHosts = BannedHosts;
			blackList = BlackList;
			browser = Browser;
			mimeType = MimeType;
			safePorts = SafePorts;
			sslPorts = SslPorts;
			unrestricted = Unrestricted;
			whiteList = WhiteList;
		}
	}
}
namespace OPNsense.proxy.forward {
	public class Authentication {
		#region Parameters
		public  children { get; set; }
		public  credentialsttl { get; set; }
		public  method { get; set; }
		public  realm { get; set; }
		#endregion Parameters

		public Authentication () {
			children = ;
			credentialsttl = ;
			method = ;
			realm = ;
		}

		public Authentication (
			 Children,
			 Credentialsttl,
			 Method,
			 Realm
		) {
			children = Children;
			credentialsttl = Credentialsttl;
			method = Method;
			realm = Realm;
		}
	}
}
namespace OPNsense.proxy.forward {
	public class Icap {
		#region Parameters
		public  enable { get; set; }
		public  EnablePreview { get; set; }
		public  EncodeUsername { get; set; }
		public  exclude { get; set; }
		public  OptionsTTL { get; set; }
		public  PreviewSize { get; set; }
		public  RequestURL { get; set; }
		public  ResponseURL { get; set; }
		public  SendClientIP { get; set; }
		public  SendUsername { get; set; }
		public  UsernameHeader { get; set; }
		#endregion Parameters

		public Icap () {
			enable = ;
			EnablePreview = ;
			EncodeUsername = ;
			exclude = ;
			OptionsTTL = ;
			PreviewSize = ;
			RequestURL = ;
			ResponseURL = ;
			SendClientIP = ;
			SendUsername = ;
			UsernameHeader = ;
		}

		public Icap (
			 Enable,
			 enablepreview,
			 encodeusername,
			 Exclude,
			 optionsttl,
			 previewsize,
			 requesturl,
			 responseurl,
			 sendclientip,
			 sendusername,
			 usernameheader
		) {
			enable = Enable;
			EnablePreview = enablepreview;
			EncodeUsername = encodeusername;
			exclude = Exclude;
			OptionsTTL = optionsttl;
			PreviewSize = previewsize;
			RequestURL = requesturl;
			ResponseURL = responseurl;
			SendClientIP = sendclientip;
			SendUsername = sendusername;
			UsernameHeader = usernameheader;
		}
	}
}
namespace OPNsense.proxy.general.cache {
	public class Local {
		#region Parameters
		public  cache_linux_packages { get; set; }
		public  cache_mem { get; set; }
		public  cache_windows_updates { get; set; }
		public  directory { get; set; }
		public  enabled { get; set; }
		public  l1 { get; set; }
		public  l2 { get; set; }
		public  maximum_object_size { get; set; }
		public  size { get; set; }
		#endregion Parameters

		public Local () {
			cache_linux_packages = ;
			cache_mem = ;
			cache_windows_updates = ;
			directory = ;
			enabled = ;
			l1 = ;
			l2 = ;
			maximum_object_size = ;
			size = ;
		}

		public Local (
			 Cache_Linux_Packages,
			 Cache_Mem,
			 Cache_Windows_Updates,
			 Directory,
			 Enabled,
			 L1,
			 L2,
			 Maximum_Object_Size,
			 Size
		) {
			cache_linux_packages = Cache_Linux_Packages;
			cache_mem = Cache_Mem;
			cache_windows_updates = Cache_Windows_Updates;
			directory = Directory;
			enabled = Enabled;
			l1 = L1;
			l2 = L2;
			maximum_object_size = Maximum_Object_Size;
			size = Size;
		}
	}
}
namespace OPNsense.proxy.general.logging {
	public class Enable {
		#region Parameters
		public  accessLog { get; set; }
		public  storeLog { get; set; }
		#endregion Parameters

		public Enable () {
			accessLog = ;
			storeLog = ;
		}

		public Enable (
			 AccessLog,
			 StoreLog
		) {
			accessLog = AccessLog;
			storeLog = StoreLog;
		}
	}
}
namespace OPNsense.proxy.general {
	public class Logging {
		#region Parameters
		public  ignoreLogACL { get; set; }
		public  target { get; set; }
		#endregion Parameters

		public Logging () {
			ignoreLogACL = ;
			target = ;
		}

		public Logging (
			 IgnoreLogACL,
			 Target
		) {
			ignoreLogACL = IgnoreLogACL;
			target = Target;
		}
	}
}
namespace OPNsense.proxy.general {
	public class Traffic {
		#region Parameters
		public  enabled { get; set; }
		public  maxDownloadSize { get; set; }
		public  maxUploadSize { get; set; }
		public  OverallBandwidthTrotteling { get; set; }
		public  perHostTrotteling { get; set; }
		#endregion Parameters

		public Traffic () {
			enabled = ;
			maxDownloadSize = ;
			maxUploadSize = ;
			OverallBandwidthTrotteling = ;
			perHostTrotteling = ;
		}

		public Traffic (
			 Enabled,
			 MaxDownloadSize,
			 MaxUploadSize,
			 overallbandwidthtrotteling,
			 PerHostTrotteling
		) {
			enabled = Enabled;
			maxDownloadSize = MaxDownloadSize;
			maxUploadSize = MaxUploadSize;
			OverallBandwidthTrotteling = overallbandwidthtrotteling;
			perHostTrotteling = PerHostTrotteling;
		}
	}
}
namespace OPNsense.proxy {
	public class Forward {
		#region Parameters
		public bool addACLforInterfaceSubnets { get; set; }
		public PSObject ftpInterfaces { get; set; }
		public uint16 ftpPort { get; set; }
		public bool ftpTransparentMode { get; set; }
		public PSObject interfaces { get; set; }
		public uint16 port { get; set; }
		public bool snmp_enable { get; set; }
		public string snmp_password { get; set; }
		public uint16 snmp_port { get; set; }
		public bool sslbump { get; set; }
		public uint16 sslbumpport { get; set; }
		public  sslcertificate { get; set; }
		public byte sslcrtd_children { get; set; }
		public Object sslnobumpsites { get; set; }
		public bool sslurlonly { get; set; }
		public uint16 ssl_crtd_storage_max_size { get; set; }
		public bool transparentMode { get; set; }
		#endregion Parameters

		public Forward () {
			addACLforInterfaceSubnets = true;
			ftpInterfaces = null;
			ftpPort = 2121;
			ftpTransparentMode = true;
			interfaces = null;
			port = 3128;
			snmp_enable = true;
			snmp_password = "public";
			snmp_port = 3401;
			sslbump = true;
			sslbumpport = 3129;
			sslcertificate = ;
			sslcrtd_children = 5;
			sslnobumpsites = null;
			sslurlonly = true;
			ssl_crtd_storage_max_size = 4;
			transparentMode = true;
		}

		public Forward (
			byte AddACLforInterfaceSubnets,
			PSObject FtpInterfaces,
			uint16 FtpPort,
			byte FtpTransparentMode,
			PSObject Interfaces,
			uint16 Port,
			byte Snmp_Enable,
			string Snmp_Password,
			uint16 Snmp_Port,
			byte Sslbump,
			uint16 Sslbumpport,
			 Sslcertificate,
			byte Sslcrtd_Children,
			Object Sslnobumpsites,
			byte Sslurlonly,
			uint16 Ssl_Crtd_Storage_Max_Size,
			byte TransparentMode
		) {
			addACLforInterfaceSubnets = (AddACLforInterfaceSubnets == 0) ? false : true;
			ftpInterfaces = FtpInterfaces;
			ftpPort = FtpPort;
			ftpTransparentMode = (FtpTransparentMode == 0) ? false : true;
			interfaces = Interfaces;
			port = Port;
			snmp_enable = (Snmp_Enable == 0) ? false : true;
			snmp_password = Snmp_Password;
			snmp_port = Snmp_Port;
			sslbump = (Sslbump == 0) ? false : true;
			sslbumpport = Sslbumpport;
			sslcertificate = Sslcertificate;
			sslcrtd_children = Sslcrtd_Children;
			sslnobumpsites = Sslnobumpsites;
			sslurlonly = (Sslurlonly == 0) ? false : true;
			ssl_crtd_storage_max_size = Ssl_Crtd_Storage_Max_Size;
			transparentMode = (TransparentMode == 0) ? false : true;
		}
	}
}
namespace OPNsense.proxy {
	public class General {
		#region Parameters
		public Object alternateDNSservers { get; set; }
		public bool dnsV4First { get; set; }
		public bool enabled { get; set; }
		public PSObject forwardedForHandling { get; set; }
		public uint16 icpPort { get; set; }
		public bool suppressVersion { get; set; }
		public PSObject uriWhitespaceHandling { get; set; }
		public bool useViaHeader { get; set; }
		public string VisibleEmail { get; set; }
		public string VisibleHostname { get; set; }
		#endregion Parameters

		public General () {
			alternateDNSservers = null;
			dnsV4First = true;
			enabled = true;
			forwardedForHandling = null;
			icpPort = 0;
			suppressVersion = true;
			uriWhitespaceHandling = null;
			useViaHeader = true;
			VisibleEmail = "admin@localhost.local";
			VisibleHostname = null;
		}

		public General (
			Object AlternateDNSservers,
			byte DnsV4First,
			byte Enabled,
			PSObject ForwardedForHandling,
			uint16 IcpPort,
			byte SuppressVersion,
			PSObject UriWhitespaceHandling,
			byte UseViaHeader,
			string visibleemail,
			string visiblehostname
		) {
			alternateDNSservers = AlternateDNSservers;
			dnsV4First = (DnsV4First == 0) ? false : true;
			enabled = (Enabled == 0) ? false : true;
			forwardedForHandling = ForwardedForHandling;
			icpPort = IcpPort;
			suppressVersion = (SuppressVersion == 0) ? false : true;
			uriWhitespaceHandling = UriWhitespaceHandling;
			useViaHeader = (UseViaHeader == 0) ? false : true;
			VisibleEmail = visibleemail;
			VisibleHostname = visiblehostname;
		}
	}
}
