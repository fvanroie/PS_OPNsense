using System;
using System.Management.Automation;

namespace OPNsense.telegraf.key.keys {
	public class Key {
		#region Parameters
		public bool enabled { get; set; }
		public string name { get; set; }
		public string value { get; set; }
		#endregion Parameters

		public Key () {
			enabled = true;
			name = null;
			value = null;
		}

		public Key (
			byte Enabled,
			string Name,
			string Value
		) {
			enabled = (Enabled == 0) ? false : true;
			name = Name;
			value = Value;
		}
	}
}
namespace OPNsense.telegraf {
	public class Output {
		#region Parameters
		public bool elastic_enable { get; set; }
		public string elastic_indexname { get; set; }
		public int elastic_timeout { get; set; }
		public string elastic_url { get; set; }
		public bool graphite_enable { get; set; }
		public string graphite_prefix { get; set; }
		public string graphite_server { get; set; }
		public string graphite_template { get; set; }
		public bool graphite_verify { get; set; }
		public bool graylog_enable { get; set; }
		public string graylog_server { get; set; }
		public string influx_database { get; set; }
		public bool influx_enable { get; set; }
		public string influx_password { get; set; }
		public int influx_timeout { get; set; }
		public string influx_url { get; set; }
		public string influx_username { get; set; }
		public bool prometheus_enable { get; set; }
		public Object prometheus_exclude { get; set; }
		public PSObject prometheus_listen { get; set; }
		public bool prometheus_stringaslabel { get; set; }
		#endregion Parameters

		public Output () {
			elastic_enable = true;
			elastic_indexname = "telegraf-%Y.%m.%d";
			elastic_timeout = 5;
			elastic_url = null;
			graphite_enable = true;
			graphite_prefix = null;
			graphite_server = null;
			graphite_template = null;
			graphite_verify = true;
			graylog_enable = true;
			graylog_server = null;
			influx_database = null;
			influx_enable = true;
			influx_password = null;
			influx_timeout = 5;
			influx_url = null;
			influx_username = null;
			prometheus_enable = true;
			prometheus_exclude = null;
			prometheus_listen = null;
			prometheus_stringaslabel = true;
		}

		public Output (
			byte Elastic_Enable,
			string Elastic_Indexname,
			int Elastic_Timeout,
			string Elastic_Url,
			byte Graphite_Enable,
			string Graphite_Prefix,
			string Graphite_Server,
			string Graphite_Template,
			byte Graphite_Verify,
			byte Graylog_Enable,
			string Graylog_Server,
			string Influx_Database,
			byte Influx_Enable,
			string Influx_Password,
			int Influx_Timeout,
			string Influx_Url,
			string Influx_Username,
			byte Prometheus_Enable,
			Object Prometheus_Exclude,
			PSObject Prometheus_Listen,
			byte Prometheus_Stringaslabel
		) {
			elastic_enable = (Elastic_Enable == 0) ? false : true;
			elastic_indexname = Elastic_Indexname;
			elastic_timeout = Elastic_Timeout;
			elastic_url = Elastic_Url;
			graphite_enable = (Graphite_Enable == 0) ? false : true;
			graphite_prefix = Graphite_Prefix;
			graphite_server = Graphite_Server;
			graphite_template = Graphite_Template;
			graphite_verify = (Graphite_Verify == 0) ? false : true;
			graylog_enable = (Graylog_Enable == 0) ? false : true;
			graylog_server = Graylog_Server;
			influx_database = Influx_Database;
			influx_enable = (Influx_Enable == 0) ? false : true;
			influx_password = Influx_Password;
			influx_timeout = Influx_Timeout;
			influx_url = Influx_Url;
			influx_username = Influx_Username;
			prometheus_enable = (Prometheus_Enable == 0) ? false : true;
			prometheus_exclude = Prometheus_Exclude;
			prometheus_listen = Prometheus_Listen;
			prometheus_stringaslabel = (Prometheus_Stringaslabel == 0) ? false : true;
		}
	}
}
namespace OPNsense.telegraf {
	public class Input {
		#region Parameters
		public bool collect_cpu_time { get; set; }
		public bool cpu { get; set; }
		public bool cpu_percpu { get; set; }
		public bool cpu_totalcpu { get; set; }
		public bool disk { get; set; }
		public bool diskio { get; set; }
		public Object disk_ignore_fs { get; set; }
		public string disk_mount_points { get; set; }
		public bool haproxy { get; set; }
		public bool mem { get; set; }
		public bool network { get; set; }
		public bool pf { get; set; }
		public bool ping { get; set; }
		public Object ping_hosts { get; set; }
		public bool processes { get; set; }
		public bool swap { get; set; }
		public bool system { get; set; }
		#endregion Parameters

		public Input () {
			collect_cpu_time = true;
			cpu = true;
			cpu_percpu = true;
			cpu_totalcpu = true;
			disk = true;
			diskio = true;
			disk_ignore_fs = null;
			disk_mount_points = null;
			haproxy = true;
			mem = true;
			network = true;
			pf = true;
			ping = true;
			ping_hosts = null;
			processes = true;
			swap = true;
			system = true;
		}

		public Input (
			byte Collect_Cpu_Time,
			byte Cpu,
			byte Cpu_Percpu,
			byte Cpu_Totalcpu,
			byte Disk,
			byte Diskio,
			Object Disk_Ignore_Fs,
			string Disk_Mount_Points,
			byte Haproxy,
			byte Mem,
			byte Network,
			byte Pf,
			byte Ping,
			Object Ping_Hosts,
			byte Processes,
			byte Swap,
			byte System
		) {
			collect_cpu_time = (Collect_Cpu_Time == 0) ? false : true;
			cpu = (Cpu == 0) ? false : true;
			cpu_percpu = (Cpu_Percpu == 0) ? false : true;
			cpu_totalcpu = (Cpu_Totalcpu == 0) ? false : true;
			disk = (Disk == 0) ? false : true;
			diskio = (Diskio == 0) ? false : true;
			disk_ignore_fs = Disk_Ignore_Fs;
			disk_mount_points = Disk_Mount_Points;
			haproxy = (Haproxy == 0) ? false : true;
			mem = (Mem == 0) ? false : true;
			network = (Network == 0) ? false : true;
			pf = (Pf == 0) ? false : true;
			ping = (Ping == 0) ? false : true;
			ping_hosts = Ping_Hosts;
			processes = (Processes == 0) ? false : true;
			swap = (Swap == 0) ? false : true;
			system = (System == 0) ? false : true;
		}
	}
}
namespace OPNsense.telegraf {
	public class General {
		#region Parameters
		public int collection_jitter { get; set; }
		public bool enabled { get; set; }
		public int flush_interval { get; set; }
		public int flush_jitter { get; set; }
		public string hostname { get; set; }
		public int interval { get; set; }
		public int metric_batch_size { get; set; }
		public int metric_buffer_limit { get; set; }
		public bool omit_hostname { get; set; }
		public bool roundinterval { get; set; }
		#endregion Parameters

		public General () {
			collection_jitter = 0;
			enabled = true;
			flush_interval = 10;
			flush_jitter = 0;
			hostname = null;
			interval = 10;
			metric_batch_size = 1000;
			metric_buffer_limit = 10000;
			omit_hostname = true;
			roundinterval = true;
		}

		public General (
			int Collection_Jitter,
			byte Enabled,
			int Flush_Interval,
			int Flush_Jitter,
			string Hostname,
			int Interval,
			int Metric_Batch_Size,
			int Metric_Buffer_Limit,
			byte Omit_Hostname,
			byte Roundinterval
		) {
			collection_jitter = Collection_Jitter;
			enabled = (Enabled == 0) ? false : true;
			flush_interval = Flush_Interval;
			flush_jitter = Flush_Jitter;
			hostname = Hostname;
			interval = Interval;
			metric_batch_size = Metric_Batch_Size;
			metric_buffer_limit = Metric_Buffer_Limit;
			omit_hostname = (Omit_Hostname == 0) ? false : true;
			roundinterval = (Roundinterval == 0) ? false : true;
		}
	}
}
