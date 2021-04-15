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
   * ~Do we need to follow the spec harness as closely as we are doing now? E.g. for our #find_by_id method, we built/passed tests converting the id to a string, but in harness it is passed as an integer. Does this level of detail matter?~
   * BigDecimal updates to SpecHarness - we updated the SpecHarness syntax to get BigDecimal running in 2.7.2. Is that ok?
   * Clarity: What does it mean to not ignore, but not design our project around SpecHarness? Should we focus on making sure all SpecHarness tests pass?
   * Would it be a good idea to use the examples they have in the SpecHarness to ensure alignment? (while still creating our own tests, just using their examples from the data)
   * How will instructors use SpecHarness in evaluating the project?
* Module vs. Parent class for parse_csv method? 
   * Where to start when creating a parent class?
* Advice/tips/resources on traversing verticals?
   * Additional visuals? (e.g. with Futbol)
* Naming convention input?   
