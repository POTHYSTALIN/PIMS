<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:setting:latestMyApp">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="list" access="public" returntype="query" output="false">
		<cfargument name="ID" type="numeric" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			SELECT
				t.*, TC.name as Category, tt.name as Type, tm.name as Mode,
				CONCAT(p1.fname, ' ', p1.lname) as fromPersonName,
				ba1.accountID as fromAccount,
				CONCAT(p2.fname, ' ', p2.lname) as toPersonName,
				ba2.accountID as toAccount
			FROM transactions t
				INNER JOIN transactionCategories tc ON T.categoryID = TC.id
				INNER JOIN transactionTypes tt ON TC.typeID = tt.id
				INNER JOIN transactionModes tm ON T.modeId = TM.id
				INNER JOIN persons p1 ON t.fromPersonId = p1.id
				INNER JOIN persons p2 ON t.toPersonId = p2.id
				LEFT JOIN bankAccounts ba1 ON t.fromAccountID = ba1.id
				LEFT JOIN bankAccounts ba2 ON t.toAccountID = ba2.id
			WHERE 1 = 1
				<cfif structKeyExists(arguments, "id")>
					AND t.id = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				</cfif>
		</cfquery>

		<cfreturn local.qry/>
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="categoryId" type="numeric" required="true">
		<cfargument name="modeId" type="numeric" required="true">
		<cfargument name="fromPersonId" type="numeric" required="true">
		<cfargument name="fromAccountId" type="numeric" required="false" default="0">
		<cfargument name="toPersonId" type="numeric" required="true">
		<cfargument name="toAccountId" type="numeric" required="false" default="0">
		<cfargument name="description" type="string" required="true">
		<cfargument name="amount" type="string" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO transactions( categoryId, modeId, fromPersonId, fromAccountId, toPersonId, toAccountId, amount, description )
			VALUES(
				#arguments.categoryId#,
				#arguments.modeId#,
				#arguments.fromPersonId#,
				<cfqueryparam value="#arguments.fromAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.fromAccountId EQ 0)#">,
				#arguments.toPersonId#,
				<cfqueryparam value="#arguments.toAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.toAccountId EQ 0)#">,
				'#arguments.amount#',
				'#arguments.description#'
			)
		</cfquery>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="categoryId" type="numeric" required="true">
		<cfargument name="modeId" type="numeric" required="true">
		<cfargument name="fromPersonId" type="numeric" required="true">
		<cfargument name="fromAccountId" type="numeric" required="false" default="0">
		<cfargument name="toPersonId" type="numeric" required="true">
		<cfargument name="toAccountId" type="numeric" required="false" default="0">
		<cfargument name="description" type="string" required="true">
		<cfargument name="amount" type="string" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactions SET
				categoryId = #arguments.categoryId#,
				modeId = #arguments.modeId#,
				fromPersonId = #arguments.fromPersonId#,
				fromAccountId = <cfqueryparam value="#arguments.fromAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.fromAccountId EQ 0)#">,
				toPersonId = #arguments.toPersonId#,
				toAccountId = <cfqueryparam value="#arguments.toAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.toAccountId EQ 0)#">,
				amount = '#arguments.amount#',
				description = '#arguments.description#'
			WHERE id = #arguments.id#
		</cfquery>
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
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