<cfcomponent name="TestMockObject" extends="cfunit.src.net.sourceforge.cfunit.framework.TestCase">
	<cfset variables.root = replaceNoCase(expandPath("../"), expandPath("/"), "")  />
	<cfset variables.cfuroot = listChangeDelims( variables.root, ".", "\")  />
	<cfset variables.tstroot = "/"&variables.root&"/test" />
	
	<cffunction name="setUp" returntype="void" access="public"></cffunction>
	
	<cffunction name="testOverride" returntype="void" access="public">
		<!--- Create the mock object --->
		<cfset var mo = createObject("component", variables.cfuroot&".framework.MockObject").init(variables.cfuroot&".test.MockCFC") />
		
		<!--- Override a function --->
		<cfset mo.overrideFunction( "fakeFunction", "hello1") />
		<cfset mo.addResult( "fakeFunction", "hello2") />
		<cfset mo.addResult( "fakeFunction", "hello3") />
		
		<!--- Call the overridden function multiple time to insure it continues to return expected results --->
		<cfset assertEquals("First call failed (round 1)", "hello1", mo.fakeFunction()) />
		<cfset assertEquals("Second call failed (round 1)", "hello2", mo.fakeFunction()) />
		<cfset assertEquals("Third call failed (round 1)", "hello3", mo.fakeFunction()) />
		<cfset assertEquals("Fourth call failed (round 2)", "hello1", mo.fakeFunction("xx", "yy")) />
		<cfset assertEquals("Second call failed (round 2)", "hello2", mo.fakeFunction()) />
		<cfset assertEquals("Third call failed (round 2)", "hello3", mo.fakeFunction()) />
		<cfset assertEquals("Second call failed (round 3)", "hello1", mo.fakeFunction()) />
		<cfset assertEquals("Third call failed (round 3)", "hello2", mo.fakeFunction()) />
		
		<!--- Check the request count --->
		<cfset assertEquals("Request count for 'fakeFunction' wrong", 8, mo.getRequestCount( "fakeFunction" ) ) />
		
		<!--- Check the recorded request information --->
		<cfset results = mo.getRequest( "fakeFunction", 4 ) />
		<cfset assertTrue("Request count for 'fakeFunction' wrong", isStruct( results ) ) />
		<cfset assertEquals("Request count for 'fakeFunction' wrong", 2, structCount( results ) ) />
		
	</cffunction>
	
	<cffunction name="testOverridePrivate" returntype="void" access="public">

		<!--- Create the mock object --->
		<cfset var mo = createObject("component", variables.cfuroot&".framework.MockObject").init(variables.cfuroot&".test.MockCFC") />
		
		<!--- Override the private method --->
		<cfset mo.overrideFunction( "fakePrivateFunction", "Hello World") />
		<cfset assertEquals("Request count for 'fakePrivateFunction' wrong", 0, mo.getRequestCount( "fakePrivateFunction" ) ) />
		
		<!--- Invoke the provate method via a public proxy --->
		<cfset mo.callFakePrivateFunction() />
		
		<!--- Make sure the private method was requested once --->
		<cfset assertEquals("Request count for 'fakePrivateFunction' wrong", 1, mo.getRequestCount( "fakePrivateFunction" ) ) />
				
	</cffunction>
	
	<cffunction name="testInit" returntype="void" access="public">
		
		<!--- Create a real object and a mock object of the same type --->
		<cfset var ro = createObject("component", variables.cfuroot&".test.MockCFC") />
		<cfset var mo = createObject("component", variables.cfuroot&".framework.MockObject").init(variables.cfuroot&".test.MockCFC") />
		
		<!--- Verify that the mock object's meta is that of the overridden object --->
		<cfset assertEquals("Mock object meta data does not match a real object", getMetaData(ro), getMetaData(mo) ) />
		
		<!--- Verify that we can use this object as if it were a real one --->
		<cfset mockFunction( mo ) />
	</cffunction>
	
	<cffunction name="mockFunction" returntype="void" access="public">
		<cfargument name="cfc" type="cfunit.src.net.sourceforge.cfunit.test.MockCFC" />
	</cffunction>
</cfcomponent>