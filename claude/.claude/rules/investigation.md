When debugging, find the root cause before fixing anything.

Don't fix the first line that triggers an error — symptoms appear far from their source. Don't grep-and-patch a single error message.

Before implementing a fix:
1. Trace execution paths and check related code for the same issue
2. Check git history for context on why code exists
3. Enumerate edge cases (null, empty, concurrent, boundary)
4. Confirm the fix addresses the cause, not the symptom
