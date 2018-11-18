using System;
using System.Management.Automation;

namespace OPNsense.ZabbixAgent.settings {
	public class Features {
		#region Parameters
		public Object activeCheckServers { get; set; }
		public bool enableActiveChecks { get; set; }
		public bool enableRemoteCommands { get; set; }
		public bool logRemoteCommands { get; set; }
		public ushort refreshActiveChecks { get; set; }
		#endregion Parameters

		public Features () {
			activeCheckServers = null;
			enableActiveChecks = true;
			enableRemoteCommands = true;
			logRemoteCommands = true;
			refreshActiveChecks = 120;
		}

		public Features (
			Object ActiveCheckServers,
			byte EnableActiveChecks,
			byte EnableRemoteCommands,
			byte LogRemoteCommands,
			ushort RefreshActiveChecks
		) {
			activeCheckServers = ActiveCheckServers;
			enableActiveChecks = (EnableActiveChecks == 0) ? false : true;
			enableRemoteCommands = (EnableRemoteCommands == 0) ? false : true;
			logRemoteCommands = (LogRemoteCommands == 0) ? false : true;
			refreshActiveChecks = RefreshActiveChecks;
		}
	}
}
namespace OPNsense.ZabbixAgent.settings {
	public class Main {
		#region Parameters
		public PSObject debugLevel { get; set; }
		public bool enabled { get; set; }
		public Object listenIP { get; set; }
		public ushort listenPort { get; set; }
		public ushort logFileSize { get; set; }
		public Object serverList { get; set; }
		public string sourceIP { get; set; }
		#endregion Parameters

		public Main () {
			debugLevel = null;
			enabled = true;
			listenIP = null;
			listenPort = 10050;
			logFileSize = 100;
			serverList = null;
			sourceIP = null;
		}

		public Main (
			PSObject DebugLevel,
			byte Enabled,
			Object ListenIP,
			ushort ListenPort,
			ushort LogFileSize,
			Object ServerList,
			string SourceIP
		) {
			debugLevel = DebugLevel;
			enabled = (Enabled == 0) ? false : true;
			listenIP = ListenIP;
			listenPort = ListenPort;
			logFileSize = LogFileSize;
			serverList = ServerList;
			sourceIP = SourceIP;
		}
	}
}
namespace OPNsense.ZabbixAgent.settings {
	public class Tuning {
		#region Parameters
		public ushort bufferSend { get; set; }
		public ushort bufferSize { get; set; }
		public ushort maxLinesPerSecond { get; set; }
		public byte startAgents { get; set; }
		public byte timeout { get; set; }
		#endregion Parameters

		public Tuning () {
			bufferSend = 5;
			bufferSize = 100;
			maxLinesPerSecond = 100;
			startAgents = 3;
			timeout = 3;
		}

		public Tuning (
			ushort BufferSend,
			ushort BufferSize,
			ushort MaxLinesPerSecond,
			byte StartAgents,
			byte Timeout
		) {
			bufferSend = BufferSend;
			bufferSize = BufferSize;
			maxLinesPerSecond = MaxLinesPerSecond;
			startAgents = StartAgents;
			timeout = Timeout;
		}
	}
}
namespace OPNsense.ZabbixAgent {
	public class Local {
		#region Parameters
		public string hostname { get; set; }
		#endregion Parameters

		public Local () {
			hostname = "Zabbix agent";
		}

		public Local (
			string Hostname
		) {
			hostname = Hostname;
		}
	}
}
