<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>

  <!--
      dfs.replication
  
      Default block replication. The actual number of replications can be
      specified when the file is created. The default is used if replication is
      not specified in create time.    
      
      Default: 3
  -->  
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
  
  <!--
      dfs.permissions.enabled
      
      If "true", enable permission checking in HDFS. If "false", permission
      checking is turned off, but all other behavior is unchanged. Switching
      from one parameter value to the other does not change the mode, owner or
      group of files or directories.
      
      Default: true
  -->
  <property>
    <name>dfs.permissions.enabled</name>
    <value>false</value>
  </property>
  
  <!--
      dfs.namenode.rpc-bind-host
      
      The actual address the RPC server will bind to. If this optional address
      is set, it overrides only the hostname portion of
      dfs.namenode.rpc-address. It can also be specified per name node or name
      service for HA/Federation. This is useful for making the name node listen
      on all interfaces by setting it to 0.0.0.0.
  -->
  <property>
    <name>dfs.namenode.rpc-bind-host</name>
    <value>${HOSTNAME}</value>
  </property>
  
  <!--
      dfs.namenode.servicerpc-bind-host
      
      The actual address the service RPC server will bind to. If this optional
      address is set, it overrides only the hostname portion of
      dfs.namenode.servicerpc-address. It can also be specified per name node or
      name service for HA/Federation. This is useful for making the name node
      listen on all interfaces by setting it to 0.0.0.0.
  -->
  <property>
    <name>dfs.namenode.servicerpc-bind-host</name>
    <value>localhost</value>
  </property>
  
  <!--
      dfs.namenode.lifeline.rpc-bind-host
      
      The actual address the lifeline RPC server will bind to. If this optional
      address is set, it overrides only the hostname portion of
      dfs.namenode.lifeline.rpc-address. It can also be specified per name node
      or name service for HA/Federation. This is useful for making the name node
      listen on all interfaces by setting it to 0.0.0.0.
  -->
  <property>
    <name>dfs.namenode.lifeline.rpc-bind-host</name>
    <value>localhost</value>
  </property>
  
  <!--
      dfs.namenode.http-bind-host
      
      The actual address the HTTP server will bind to. If this optional address
      is set, it overrides only the hostname portion of
      dfs.namenode.http-address. It can also be specified per name node or name
      service for HA/Federation. This is useful for making the name node HTTP
      server listen on all interfaces by setting it to 0.0.0.0.
  -->
  <property>
    <name>dfs.namenode.http-bind-host</name>
    <value>localhost</value>
  </property>
  
  <!--
      dfs.namenode.https-bind-host
      
      The actual address the HTTPS server will bind to. If this optional address
      is set, it overrides only the hostname portion of
      dfs.namenode.https-address. It can also be specified per name node or name
      service for HA/Federation. This is useful for making the name node HTTPS
      server listen on all interfaces by setting it to 0.0.0.0.
  -->
  <property>
    <name>dfs.namenode.https-bind-host</name>
    <value>localhost</value>
  </property>
  
</configuration>
