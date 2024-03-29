<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans-3.0.xsd"
       default-init-method="init">

<!--

	This file contains a WaybackCollection implementation using a
	RemoteResourceIndex and a SimpleResourceStore.

	The RemoteResourceIndex implementation assumes that a Wayback is running on
	the machine indicated by "searchUrlBase", which provides an XML-HTTP search
	interface to the ResourceIndex on that machine.

	The SimpleResourceStore implementation assumes that all ARC/WARC files are
	accessible under the path/URL named in "prefix".

	When a path is specified as the "prefix", it is assumed that there exists a
	single local directory containing all ARC/WARC files.

	When a URL is specified as the "prefix", it is assumed that all ARC/WARC
	files are HTTP 1.1 exported under the directory denoted. The
	FileProxyServlet defined in wayback.xml may be useful in installations
	where ARC/WARC files are distributed across many machines, and it is
	desirable to route all ARC/WARC resource requests through a single machine.

-->

  <bean id="remotecollection" class="org.archive.wayback.webapp.WaybackCollection">

    <property name="resourceStore">
      <bean class="org.archive.wayback.resourcestore.SimpleResourceStore">
        <property name="prefix" value="http://${REPO_HOST}:${REPO_REST_PORT}/wayback/warcs/" />
      </bean>
    </property>

    <property name="resourceIndex">
      <bean class="org.archive.wayback.resourceindex.RemoteResourceIndex">
        <property name="searchUrlBase" value="http://${REPO_HOST}:${REPO_REST_PORT}/wayback/cdx/owb/${OPENWB_COLLECTION}" />
      </bean>
    </property>
  </bean>

</beans>
