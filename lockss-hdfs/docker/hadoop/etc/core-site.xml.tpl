<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>

  <!--
      fs.defaultFS
  
      The name of the default file system. A URI whose scheme and authority
      determine the FileSystem implementation. The uri's scheme determines the
      config property (fs.SCHEME.impl) naming the FileSystem implementation
      class. The uri's authority is used to determine the host, port, etc. for a
      filesystem.
    
      Default: file:///
  -->  
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://${HOSTNAME}:${HDFS_FS}</value>
  </property>
  
  <!--
      hadoop.tmp.dir
      
      A base for other temporary directories.
      
      Default: /tmp/hadoop-${user.name}	
  -->
  <property>
    <name>hadoop.tmp.dir</name>
    <value>${HADOOP_DATA}</value>
  </property>

</configuration>
