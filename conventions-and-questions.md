## Ruby Conventions

Case | Convention
--- | ---
**Creating Collections** | _Indent contents of the collection to align with the opening bracket._
**Creating Code Blocks** | _Contents of the do/end block should be tabbed in one. In tests: there should be no space between the do/end block and the expect statement if there is no setup._
**Submitting a Pull Request** | _Request review from all team members that were not participants in the changes included in the pull request. The last team member to complete their review should merge the PR, assuming no changes are requested._

## Open Questions
* Spec Helper issues:
   * Line 47 is commented out - the requirement throws an error when run locally
* Spec Harness questions:
   * Do we need to follow the spec harness as closely as we are doing now? E.g. for our #find_by_id method, we built/passed tests converting the id to a string, but in harness it is passed as an integer. Does this level of detail matter?  
