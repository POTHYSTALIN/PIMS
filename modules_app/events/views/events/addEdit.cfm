<cfoutput>
    <cfif !val( rc.id ) AND structKeyExists( rc, "start" )>
        <cfset tmpStartDate = rc.start />
    <cfelseif prc.currEvent.start EQ "">
        <cfset tmpStartDate = "" />
    <cfelse>
        <cfset tmpStartDate = dateFormat( prc.currEvent.start, "yyyy-mmm-dd" ) />
    </cfif>
    <cfif !val( rc.id ) AND structKeyExists( rc, "start" )>
        <cfset tmpEndDate = rc.start />
    <cfelseif prc.currEvent.end EQ "">
        <cfset tmpEndDate = "" />
    <cfelse>
        <cfset tmpEndDate = dateFormat( prc.currEvent.end, "yyyy-mmm-dd" ) />
    </cfif>

    <!---
        1. Name
        2. Description
        3. Category
        4. start
        5. End
        6. no.of cycles
    --->


    <form id="addEditForm" action="#event.buildLink( lCase(prc.formAction) )#" method="post">
        <input type="hidden" name="id" value="#rc.id#">
        <div class="row">
            <!--- NAME --->
            <div class="col-sm-6 form-group">
                <label for="name" class="col-form-label">Name</label>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="name" name="name" placeholder="Please enter the name" value="#prc.currEvent.title#" required>
                    <div class="invalid-feedback">Please enter the name</div>
                </div>
            </div>

            <!--- Category --->
            <div class="col-sm-6 form-group">
                <label for="eventCategoryId" class="col-form-label">Category</label>
                <select class="custom-select" id="eventCategoryId" name="eventCategoryId" required min="1" onchange="javascript: toggleFields( this );">
                    <option value="0">Please select a mode</option>
                    <cfloop query="#prc.allCategories#">
                        <option value="#prc.allCategories.id#" <cfif prc.allCategories.id EQ prc.currEvent.eventCategoryId>selected</cfif> data-mode="#prc.allCategories.name#">#prc.allCategories.name#</option>
                    </cfloop>
                </select>
                <div class="invalid-feedback">Please select a mode</div>
            </div>

            <!--- Start DATE --->
            <div class="col-sm-6 form-group">
                <label for="startDate" class="col-form-label">Start Date</label>
                <div class="input-group date mb-3">
                    <input type="text" class="form-control datepicker" id="startDate" name="startDate" placeholder="Please select a date" value="#tmpStartDate#" required>
                    <div class="input-group-append">
                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    </div>
                </div>
                <div class="invalid-feedback">Please select a date</div>
            </div>

            <!--- End DATE --->
            <div class="col-sm-6 form-group">
                <label for="endDate" class="col-form-label">End Date</label>
                <div class="input-group date mb-3">
                    <input type="text" class="form-control datepicker" id="endDate" name="endDate" placeholder="Please select a date" value="#tmpEndDate#">
                    <div class="input-group-append">
                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    </div>
                </div>
                <div class="invalid-feedback">Please select a date</div>
            </div>

            <!--- no.of cycles --->
            <div class="col-sm-6 form-group">
                <label for="no_of_repeats" class="col-form-label">No.of cycles</label>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="no_of_repeats" name="no_of_repeats" placeholder="Please enter the no.of cycles" value="#prc.currEvent.cycles#">
                    <div class="invalid-feedback">Please enter the no.of cycles</div>
                </div>
            </div>

            <!--- Description --->
            <div class="col-sm-12 form-group">
                <label for="desc" class="col-form-label">Description</label>
                <textarea class="form-control" name="desc" id="desc" rows="9">#prc.currEvent.desc#</textarea>
            </div>
        </div>
        <div class="form-group row">
            <div class="offset-9 col-sm-1 pr-0 pl-4 mr-1">
                <input type="submit" class="btn btn-success" name="Submit" value="#prc.formSubmit#">
            </div>
            <div class="col-sm-1 p-0 mr-2 ml-5">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>
    </form>
</cfoutput>