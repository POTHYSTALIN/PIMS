<cfcomponent singleton="true">
	<cfproperty name="dsn" inject="coldbox:setting:PIMS">

	<cffunction name="init" returntype="Any">
		<cfreturn this>
	</cffunction>

	<cffunction name="list" access="public" returntype="query" output="false">
		<cfargument name="id" type="numeric" required="false">
		<cfargument name="searchFrom" type="date" required="false">
		<cfargument name="searchTo" type="date" required="false">
		<cfargument name="personId" type="string" required="false" hint="list of person Ids" default="">
		<cfargument name="accountId" type="string" required="false" hint="list of person Ids" default="">

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
				AND t.archived = '0'
				<cfif structKeyExists(arguments, "id")>
					AND t.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif structKeyExists( arguments, "searchFrom" )>
					AND t.transactionDate >= <cfqueryparam value="#arguments.searchFrom#" cfsqltype="cf_sql_date" />
				</cfif>
				<cfif structKeyExists( arguments, "searchTo" )>
					AND t.transactionDate <= <cfqueryparam value="#arguments.searchTo#" cfsqltype="cf_sql_date" />
				</cfif>
				<cfif len( trim( arguments.personId ) )>
					AND (
						t.fromPersonId IN ( <cfqueryparam value="#arguments.personId#" cfsqltype="cf_sql_integer" list="true" /> )
						OR t.toPersonId IN ( <cfqueryparam value="#arguments.personId#" cfsqltype="cf_sql_integer" list="true" /> )
					)
				</cfif>
				<cfif len( trim( arguments.accountId ) )>
					AND (
						( t.fromAccountId IS NOT NULL AND t.fromAccountId IN ( <cfqueryparam value="#arguments.accountId#" cfsqltype="cf_sql_integer" list="true" /> ) )
						OR ( t.toAccountId IS NOT NULL AND t.toAccountId IN ( <cfqueryparam value="#arguments.accountId#" cfsqltype="cf_sql_integer" list="true" /> ) )
					)
				</cfif>
			ORDER BY t.transactionDate DESC
		</cfquery>

		<cfreturn local.qry/>
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="categoryId" type="numeric" required="true">
		<cfargument name="transactionDate" type="date" required="true">
		<cfargument name="modeId" type="numeric" required="true">
		<cfargument name="fromPersonId" type="numeric" required="true">
		<cfargument name="fromAccountId" type="numeric" required="false" default="0">
		<cfargument name="toPersonId" type="numeric" required="true">
		<cfargument name="toAccountId" type="numeric" required="false" default="0">
		<cfargument name="description" type="string" required="true">
		<cfargument name="amount" type="string" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			INSERT INTO transactions( categoryId, transactionDate, modeId, fromPersonId, fromAccountId, toPersonId, toAccountId, amount, description )
			VALUES(
				#arguments.categoryId#,
				<cfqueryparam value="#parseDateTime( arguments.transactionDate )#" cfsqltype="cf_sql_date">,
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
		<cfargument name="transactionDate" type="date" required="false">
		<cfargument name="categoryId" type="numeric" required="false">
		<cfargument name="modeId" type="numeric" required="false">
		<cfargument name="fromPersonId" type="numeric" required="false">
		<cfargument name="fromAccountId" type="numeric" required="false" default="0">
		<cfargument name="toPersonId" type="numeric" required="false">
		<cfargument name="toAccountId" type="numeric" required="false" default="0">
		<cfargument name="description" type="string" required="false">
		<cfargument name="amount" type="string" required="false">
		<cfargument name="archived" type="boolean" required="false">
		<cfargument name="archivedDate" type="date" required="false">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactions SET
				<cfif structKeyExists( arguments, "categoryId" )>
					categoryId = #arguments.categoryId#,
				</cfif>
				<cfif structKeyExists( arguments, "transactionDate" )>
					transactionDate = <cfqueryparam value="#parseDateTime( arguments.transactionDate )#" cfsqltype="cf_sql_date">,
				</cfif>
				<cfif structKeyExists( arguments, "modeId" )>
					modeId = #arguments.modeId#,
				</cfif>
				<cfif structKeyExists( arguments, "fromPersonId" )>
					fromPersonId = #arguments.fromPersonId#,
				</cfif>
				<cfif structKeyExists( arguments, "fromAccountId" )>
					fromAccountId = <cfqueryparam value="#arguments.fromAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.fromAccountId EQ 0)#">,
				</cfif>
				<cfif structKeyExists( arguments, "toPersonId" )>
					toPersonId = #arguments.toPersonId#,
				</cfif>
				<cfif structKeyExists( arguments, "toAccountId" )>
					toAccountId = <cfqueryparam value="#arguments.toAccountId#" cfsqltype="cf_sql_numeric" null="#(arguments.toAccountId EQ 0)#">,
				</cfif>
				<cfif structKeyExists( arguments, "amount" )>
					amount = '#arguments.amount#',
				</cfif>
				<cfif structKeyExists( arguments, "description" )>
					description = '#arguments.description#',
				</cfif>
				<cfif structKeyExists( arguments, "archived" )>
					archived = <cfqueryparam value="#arguments.archived#" cfsqltype="cf_sql_bit">,
				</cfif>
				<cfif structKeyExists( arguments, "archivedDate" )>
					archivedDate = <cfqueryparam value="#arguments.archivedDate#" cfsqltype="cf_sql_date">,
				</cfif>
				updated = getDate()
			WHERE id = #arguments.id#
		</cfquery>
	</cffunction>

	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactions SET
				deleted = 1,
				updated = getDate()
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="undelete" access="public" returntype="void" output="false">
		<cfargument name="id" type="numeric" required="true">

		<cfquery name="local.qry" datasource="#dsn.name#">
			UPDATE transactions SET
				deleted = 0,
				updated = getDate()
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>

	<cffunction name="getCurrentBalances" returntype="array" access="public" output="true">
		<cfargument name="personId" type="numeric" required="yes" />

		<cfset var res = [] />
		<cfset var currPersonBalances = "" />
		<cfset var allIncomes = "" />
		<cfset var allExpenses = "" />
		<cfset var inHandBalance = "" />
		<cfset var inBankBalance = "" />

		<cfquery name="currPersonBalances" datasource="#dsn.name#">
			SELECT
				b.*,
				tm.name as type,
				ba.accountId as account
			FROM balances b
				INNER JOIN transactionModes tm ON b.modeId = tm.id
				LEFT JOIN bankAccounts ba ON b.accountId = ba.id AND b.personId = ba.personId
			WHERE 1 = 1
				AND (
					b.personId = <cfqueryparam value="#arguments.personId#" cfsqltype="cf_sql_integer" />
					OR ba.tracked = 1
				)
				AND b.deleted = 0
		</cfquery>

		<cfquery name="allIncomes" datasource="#dsn.name#">
			SELECT
				sum( t.amount ) AS income, t.toAccountId AS accountId
			FROM transactions t
				INNER JOIN transactionModes tm ON t.modeId = tm.id
				LEFT JOIN bankAccounts ba ON t.toAccountId = ba.id AND t.toPersonId = ba.personId
			WHERE 1 = 1
				AND (
					t.toPersonId = <cfqueryparam value="#arguments.personId#" cfsqltype="cf_sql_integer" />
					OR ba.tracked = 1
				)
				AND t.deleted = 0
				AND t.archived = 0
			GROUP BY t.toAccountId
		</cfquery>

		<cfquery name="allExpenses" datasource="#dsn.name#">
			SELECT
				sum( t.amount ) AS expense, t.fromAccountId AS accountId
			FROM transactions t
				INNER JOIN transactionModes tm ON t.modeId = tm.id
				LEFT JOIN bankAccounts ba ON t.toAccountId = ba.id AND t.toPersonId = ba.personId
			WHERE 1 = 1
				AND (
					t.fromPersonId = <cfqueryparam value="#arguments.personId#" cfsqltype="cf_sql_integer" />
					OR ba.tracked = 1
				)
				AND t.deleted = 0
				AND t.archived = 0
			GROUP BY t.fromAccountId
		</cfquery>

		<cfquery name="inHandBalance" dbtype="query">
			SELECT TOP 1 * FROM currPersonBalances
			WHERE type = 'Cash'
		</cfquery>

		<cfif inHandBalance.recordcount>
			<cfquery name="handIncomes" dbtype="query">
				SELECT TOP 1 * FROM allIncomes
				WHERE accountId = NULL
			</cfquery>

			<cfquery name="handExpenses" dbtype="query">
				SELECT TOP 1 * FROM allExpenses
				WHERE accountId = NULL
			</cfquery>

			<cfset res.append({
				"id": inHandBalance.id,
				"type": "hand",
				"account": "",
				"accountName": "In Hand",
				"amount": val( inHandBalance.amount ) + val( handIncomes.income ) - val( handExpenses.expense )
			}) />
		</cfif>

		<cfquery name="inBankBalance" dbtype="query">
			SELECT * FROM currPersonBalances
			WHERE type = 'Transfer'
		</cfquery>

		<cfloop query="inBankBalance">
			<cfquery name="bankIncomes" dbtype="query">
				SELECT TOP 1 * FROM allIncomes
				WHERE accountId = #inBankBalance.accountId#
			</cfquery>

			<cfquery name="bankExpenses" dbtype="query">
				SELECT TOP 1 * FROM allExpenses
				WHERE accountId = #inBankBalance.accountId#
			</cfquery>
			<cfset res.append( {
				"id": inBankBalance.id,
				"type": "bank",
				"account": inBankBalance.accountId,
				"accountName": inBankBalance.account,
				"amount": val( inBankBalance.amount ) + val( bankIncomes.income ) - val( bankExpenses.expense )
			}) />
		</cfloop>

		<cfreturn res />
	</cffunction>

	<cffunction name="reCreateBalance" access="public" returntype="void">
		<cfargument name="id" type="numeric" required="true" />
		<cfargument name="balance" type="numeric" required="true" />
		<cfargument name="archivedDate" type="date" required="true" />

		<cfquery datasource="#dsn.name#">
			INSERT INTO balances( personId, modeId, accountId, amount )
			SELECT personId, modeId, accountId, <cfqueryparam value="#arguments.balance#" cfsqltype="cf_sql_float" />
			FROM balances
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />;
			UPDATE balances SET deleted = 1, updated = <cfqueryparam value="#arguments.archivedDate#" cfsqltype="cf_sql_date" />
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />;
		</cfquery>
	</cffunction>
</cfcomponent>