<!--- 
Tests the TestCase class
--->
 
<cfcomponent name="TestTestCase_templates" extends="cfunit.src.net.sourceforge.cfunit.framework.TestCase">
	<cfset variables.root = replaceNoCase(expandPath("../"), expandPath("/"), "")  />
	<cfset variables.cfuroot = listChangeDelims( variables.root, ".", "\")  />
	<cfset variables.tstroot = "/"&variables.root&"/test" />
	
	<cffunction name="testInclude" returntype="void" access="public">
		
		<cfset var expected = "<h2>Hello World!</h2>">
		<cfset var expectedParial = "Hello World!">
		<cfset var template = variables.tstroot&"\includeBasic.cfm">
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Basic include test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#expected#">
		</cfinvoke>
			
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Basic include test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#expectedParial#">
		</cfinvoke>
			
	</cffunction>
	
	<cffunction name="testIncludeWithIgnore" returntype="void" access="public">
		
		<cfset var expected = "<h2>Hello !</h2>">
		<cfset var expectedParial = "Hello !">
		<cfset var template = variables.tstroot&"\includeBasic.cfm">
		<cfset var ignores = ArrayNew(1) />
		<cfset ArrayAppend(ignores, "Wor") />
		<cfset ArrayAppend(ignores, "ld") />
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Basic include test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#expected#">
			<cfinvokeargument name="ignore" value="#ignores#">
		</cfinvoke>
			
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Basic include test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#expectedParial#">
			<cfinvokeargument name="ignore" value="#ignores#">
		</cfinvoke>
			
	</cffunction>
		
	<cffunction name="testIncludeWithArgumentsSet" returntype="void" access="public">
		
		<cfset var file = variables.tstroot&"\includeWithArgumentsSet.txt">
		<cfset var template = variables.tstroot&"\includeWithArguments.cfm">
		
		<cfset test0 = "Here I am">
		<cfset VARIABLES.test1 = "123">
		<cfset URL.test2 = "456">
		<cfset FORM.test3 = "789">
		<cfset COOKIES.test4 = "ABC">
		<cfset APPLICATION.test5 = "DEF">
		<cfset REQUEST.test6 = "XYZ">
		
		<!--- 
		<cfinvoke method="generateOutputs">
			<cfinvokeargument name="file" value="#file#">
			<cfinvokeargument name="template" value="#template#">
		</cfinvoke>
		--->
			
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Include w/arguments test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#file#">
		</cfinvoke>
			
	</cffunction>
	
	<cffunction name="testIncludeWithArgumentsPassed" returntype="void" access="public">
		
		<cfset var file = variables.tstroot&"\includeWithArgumentsPassed.txt">
		<cfset var template = variables.tstroot&"\includeWithArguments.cfm">
		
		<cfset var theseVars = StructNew()>
		
		<cfset theseVars["test0"] = "Here I am">
		<cfset theseVars["VARIABLES.test1"] = "123">
		<cfset theseVars["URL.test2"] = "456">
		<cfset theseVars["FORM.test3"] = "789">
		<cfset theseVars["COOKIES.test4"] = "ABC">
		<cfset theseVars["APPLICATION.test5"] = "DEF">
		<cfset theseVars["REQUEST.test6"] = "XYZ">
		
		<!---
		<cfinvoke method="generateOutputs">
			<cfinvokeargument name="file" value="#file#">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
		 --->
			
		<cfinvoke method="assertOutputs" message="Valided Failure" template="#template#" expected="#file#" args="#theseVars#" />
			
	</cffunction>
	
	<cffunction name="testModule" returntype="void" access="public">
		
		<cfset var expected = "<h2>Hello World From Module!</h2>">
		<cfset var template = variables.tstroot&"\moduleBasic.cfm">
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Basic module test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#expected#">
			<cfinvokeargument name="type" value="MODULE">
		</cfinvoke>
			
	</cffunction>
	
	<cffunction name="testModuleWithAttributes" returntype="void" access="public">
		
		<cfset var file = variables.tstroot&"\moduleWithAttributes.txt">
		<cfset var template = variables.tstroot&"\moduleWithAttributes.cfm">
		
		<cfset var theseVars = StructNew()>
		
		<cfset theseVars["firstAttribute"] = "1,2,3">
		<cfset theseVars["secondAttribute"] = "A,B,C">
		<cfset theseVars["lastAttribute"] = "I,II,III">
		<!--- <cfdump var="#ExpandPath("/")#"><cfabort> --->
		<!---  
		<cfinvoke method="generateOutputs">
			<cfinvokeargument name="file" value="#file#">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="type" value="MODULE">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
		 --->
			
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Module w/attributes test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#file#">
			<cfinvokeargument name="type" value="MODULE">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Module w/attributes test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#theseVars['firstAttribute']#">
			<cfinvokeargument name="type" value="MODULE">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Module w/attributes test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#theseVars['secondAttribute']#">
			<cfinvokeargument name="type" value="MODULE">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
		
		<cfinvoke method="assertOutputs">
			<cfinvokeargument name="message" value="Module w/attributes test failed">
			<cfinvokeargument name="template" value="#template#">
			<cfinvokeargument name="expected" value="#theseVars['lastAttribute']#">
			<cfinvokeargument name="type" value="MODULE">
			<cfinvokeargument name="args" value="#theseVars#">
		</cfinvoke>
	</cffunction>
</cfcomponent>