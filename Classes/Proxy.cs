using System;
using System.Management.Automation;

namespace OPNsense.proxy.forward.acl {
	public class Remoteacls {
		#region Parameters
		public PSObject UpdateCron { get; set; }
		#endregion Parameters

		public Remoteacls () {
			UpdateCron = null;
		}

		public Remoteacls (
			PSObject updatecron
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
		public Object allowedSubnets { get; set; }
		public Object bannedHosts { get; set; }
		public Object blackList { get; set; }
		public Object browser { get; set; }
		public Object mimeType { get; set; }
		public Object safePorts { get; set; }
		public Object sslPorts { get; set; }
		public Object unrestricted { get; set; }
		public Object whiteList { get; set; }
		#endregion Parameters

		public Acl () {
			allowedSubnets = null;
			bannedHosts = null;
			blackList = null;
			browser = null;
			mimeType = null;
			safePorts = null;
			sslPorts = null;
			unrestricted = null;
			whiteList = null;
		}

		public Acl (
			Object AllowedSubnets,
			Object BannedHosts,
			Object BlackList,
			Object Browser,
			Object MimeType,
			Object SafePorts,
			Object SslPorts,
			Object Unrestricted,
			Object WhiteList
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
		public uint children { get; set; }
		public uint credentialsttl { get; set; }
		public PSObject method { get; set; }
		public string realm { get; set; }
		#endregion Parameters

		public Authentication () {
			children = 5;
			credentialsttl = 2;
			method = null;
			realm = "OPNsense proxy authentication";
		}

		public Authentication (
			uint Children,
			uint Credentialsttl,
			PSObject Method,
			string Realm
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
		public bool enable { get; set; }
		public bool EnablePreview { get; set; }
		public bool EncodeUsername { get; set; }
		public Object exclude { get; set; }
		public int OptionsTTL { get; set; }
		public int PreviewSize { get; set; }
		public string RequestURL { get; set; }
		public string ResponseURL { get; set; }
		public bool SendClientIP { get; set; }
		public bool SendUsername { get; set; }
		public string UsernameHeader { get; set; }
		#endregion Parameters

		public Icap () {
			enable = true;
			EnablePreview = true;
			EncodeUsername = true;
			exclude = null;
			OptionsTTL = 60;
			PreviewSize = 1024;
			RequestURL = "icap://[::1]:1344/avscan";
			ResponseURL = "icap://[::1]:1344/avscan";
			SendClientIP = true;
			SendUsername = true;
			UsernameHeader = "X-Username";
		}

		public Icap (
			byte Enable,
			byte enablepreview,
			byte encodeusername,
			Object Exclude,
			int optionsttl,
			int previewsize,
			string requesturl,
			string responseurl,
			byte sendclientip,
			byte sendusername,
			string usernameheader
		) {
			enable = (Enable == 0) ? false : true;
			EnablePreview = (enablepreview == 0) ? false : true;
			EncodeUsername = (encodeusername == 0) ? false : true;
			exclude = Exclude;
			OptionsTTL = optionsttl;
			PreviewSize = previewsize;
			RequestURL = requesturl;
			ResponseURL = responseurl;
			SendClientIP = (sendclientip == 0) ? false : true;
			SendUsername = (sendusername == 0) ? false : true;
			UsernameHeader = usernameheader;
		}
	}
}
namespace OPNsense.proxy.general.cache {
	public class Local {
		#region Parameters
		public bool cache_linux_packages { get; set; }
		public uint cache_mem { get; set; }
		public bool cache_windows_updates { get; set; }
		public string directory { get; set; }
		public bool enabled { get; set; }
		public uint l1 { get; set; }
		public uint l2 { get; set; }
		public uint maximum_object_size { get; set; }
		public uint size { get; set; }
		#endregion Parameters

		public Local () {
			cache_linux_packages = true;
			cache_mem = 256;
			cache_windows_updates = true;
			directory = "/var/squid/cache";
			enabled = true;
			l1 = 16;
			l2 = 256;
			maximum_object_size = 0;
			size = 100;
		}

		public Local (
			byte Cache_Linux_Packages,
			uint Cache_Mem,
			byte Cache_Windows_Updates,
			string Directory,
			byte Enabled,
			uint L1,
			uint L2,
			uint Maximum_Object_Size,
			uint Size
		) {
			cache_linux_packages = (Cache_Linux_Packages == 0) ? false : true;
			cache_mem = Cache_Mem;
			cache_windows_updates = (Cache_Windows_Updates == 0) ? false : true;
			directory = Directory;
			enabled = (Enabled == 0) ? false : true;
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
		public bool accessLog { get; set; }
		public bool storeLog { get; set; }
		#endregion Parameters

		public Enable () {
			accessLog = true;
			storeLog = true;
		}

		public Enable (
			byte AccessLog,
			byte StoreLog
		) {
			accessLog = (AccessLog == 0) ? false : true;
			storeLog = (StoreLog == 0) ? false : true;
		}
	}
}
namespace OPNsense.proxy.general {
	public class Logging {
		#region Parameters
		public Object ignoreLogACL { get; set; }
		public PSObject target { get; set; }
		#endregion Parameters

		public Logging () {
			ignoreLogACL = null;
			target = null;
		}

		public Logging (
			Object IgnoreLogACL,
			PSObject Target
		) {
			ignoreLogACL = IgnoreLogACL;
			target = Target;
		}
	}
}
namespace OPNsense.proxy.general {
	public class Traffic {
		#region Parameters
		public bool enabled { get; set; }
		public uint maxDownloadSize { get; set; }
		public uint maxUploadSize { get; set; }
		public uint OverallBandwidthTrotteling { get; set; }
		public uint perHostTrotteling { get; set; }
		#endregion Parameters

		public Traffic () {
			enabled = true;
			maxDownloadSize = 2048;
			maxUploadSize = 1024;
			OverallBandwidthTrotteling = 1024;
			perHostTrotteling = 256;
		}

		public Traffic (
			byte Enabled,
			uint MaxDownloadSize,
			uint MaxUploadSize,
			uint overallbandwidthtrotteling,
			uint PerHostTrotteling
		) {
			enabled = (Enabled == 0) ? false : true;
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
		public ushort ftpPort { get; set; }
		public bool ftpTransparentMode { get; set; }
		public PSObject interfaces { get; set; }
		public ushort port { get; set; }
		public bool snmp_enable { get; set; }
		public string snmp_password { get; set; }
		public ushort snmp_port { get; set; }
		public bool sslbump { get; set; }
		public ushort sslbumpport { get; set; }
		public PSObject sslcertificate { get; set; }
		public byte sslcrtd_children { get; set; }
		public Object sslnobumpsites { get; set; }
		public bool sslurlonly { get; set; }
		public ushort ssl_crtd_storage_max_size { get; set; }
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
			sslcertificate = null;
			sslcrtd_children = 5;
			sslnobumpsites = null;
			sslurlonly = true;
			ssl_crtd_storage_max_size = 4;
			transparentMode = true;
		}

		public Forward (
			byte AddACLforInterfaceSubnets,
			PSObject FtpInterfaces,
			ushort FtpPort,
			byte FtpTransparentMode,
			PSObject Interfaces,
			ushort Port,
			byte Snmp_Enable,
			string Snmp_Password,
			ushort Snmp_Port,
			byte Sslbump,
			ushort Sslbumpport,
			PSObject Sslcertificate,
			byte Sslcrtd_Children,
			Object Sslnobumpsites,
			byte Sslurlonly,
			ushort Ssl_Crtd_Storage_Max_Size,
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
		public ushort icpPort { get; set; }
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
			ushort IcpPort,
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
