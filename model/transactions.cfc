<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:datasource:inoutcomes">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="getTransactions" access="public" returntype="query" output="false">
		<cfargument name="ID" type="numeric" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT
				T.*, TC.name as Category, TT.name as Type, CONCAT(P.fname, ' ', P.lname) as Person
			FROM transactions T
				INNER JOIN transactionCategories TC ON T.categoryID = TC.ID
				INNER JOIN transactionTypes TT ON TC.typeID = TT.ID
				INNER JOIN persons P ON T.personID = P.ID
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "ID")>
					AND T.ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
		</cfquery>

		<cfreturn local.qry/>
	</cffunction>

	<cffunction name="newTransaction" access="public" returntype="void" output="false">
		<cfargument name="categoryID" type="numeric" required="true">
		<cfargument name="personID" type="numeric" required="true">
		<cfargument name="description" type="string" required="true">
		<cfargument name="amount" type="string" required="true">
		<cfargument name="bankAccountID" type="numeric" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO transactions( categoryID, personID, description, amount )
			VALUES( #arguments.categoryID#, #arguments.personID#, '#arguments.description#', '#arguments.amount#')
		</cfquery>
	</cffunction>

	<cffunction name="updateTransaction" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">
		<cfargument name="categoryID" type="numeric" required="true">
		<cfargument name="personID" type="numeric" required="true">
		<cfargument name="description" type="string" required="true">
		<cfargument name="amount" type="string" required="true">
		<cfargument name="bankAccountID" type="numeric" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactions
			SET
				categoryID = #arguments.categoryID#
				personID = #arguments.personID#
				description = '#arguments.description#'
				amount = '#arguments.amount#'
			WHERE ID = #arguments.ID#
		</cfquery>
	</cffunction>

	<cffunction name="deleteTransaction" access="public" returntype="void" output="false">
		<cfargument name="ID" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[transactions_deleted]') AND type in (N'U'))
			BEGIN
				CREATE TABLE transactions_deleted(
					id int primary key identity(1,1),
					categoryID int,
					bankAccountID int,
					personID int not null,
					description text,
					amount money,
					created datetime default(getDate()),
					updated datetime default(getDate()),
					deleted bit default(0)
				)
			END
			INSERT INTO transactions_deleted( categoryID, bankAccountID, personID, description, amount, created, updated, deleted )
			SELECT categoryID, bankAccountID, personID, description, amount, created, updated, deleted FROM transactions WHERE ID = #arguments.ID#;
			DELETE FROM transactions WHERE ID = #arguments.ID#;
		</cfquery>
	</cffunction>
</cfcomponent>