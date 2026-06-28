=========================================================
SNOWPIPE MONITORING TUTORIAL
=========================================================

Introduction
---------------------------------------------------------

Once Snowpipe is implemented in production,
our responsibility is not only to ingest files
but also to monitor whether Snowpipe is working correctly.

Questions we should be able to answer:

✓ Is the pipe running?
✓ Are files getting loaded?
✓ Are any files failing?
✓ Are there pending files?
✓ Is S3 notification working?
✓ How many rows are being loaded daily?

=========================================================
1. MONITOR PIPE STATUS
=========================================================

Purpose
---------------------------------------------------------

Check Snowpipe health and current status.

Command
---------------------------------------------------------

SELECT SYSTEM$PIPE_STATUS('CUSTOMER_PIPE');

What Information Does It Provide?
---------------------------------------------------------

✓ Execution State
✓ Pending Files
✓ Notification Activity
✓ Last Received Message

Example Output
---------------------------------------------------------

{
  "executionState":"RUNNING",
  "pendingFileCount":0,
  "lastReceivedMessageTimestamp":"2026-06-13"
}


executionState = RUNNING

→ Snowpipe is active

pendingFileCount > 0

→ Files are waiting to be processed

Real Use Case
---------------------------------------------------------

Business says:

"Today's file is not loaded."

First thing to check:

SYSTEM$PIPE_STATUS()

=========================================================
2. SHOW ALL PIPES
=========================================================

Purpose
---------------------------------------------------------

List all Snowpipes in the environment.

Command
---------------------------------------------------------

SHOW PIPES;

Example Output
---------------------------------------------------------

CUSTOMER_PIPE
SALES_PIPE
PRODUCT_PIPE

Useful to verify:

✓ Pipe exists
✓ Auto ingest enabled

=========================================================
3. DESCRIBE PIPE
=========================================================

Purpose
---------------------------------------------------------

View Snowpipe configuration.

Command
---------------------------------------------------------

DESC PIPE CUSTOMER_PIPE;

Information Available
---------------------------------------------------------

✓ Pipe Definition
✓ COPY INTO Statement
✓ Notification Channel
✓ Auto Ingest Setting

Real Use Case
---------------------------------------------------------

Need to check:

Which table is Snowpipe loading?

Use DESC PIPE.

=========================================================
4. MONITOR FILE LOADS USING COPY_HISTORY
=========================================================

Purpose
---------------------------------------------------------

Track files loaded by Snowpipe.

Command
---------------------------------------------------------

SELECT *
FROM TABLE(
 INFORMATION_SCHEMA.COPY_HISTORY(
 TABLE_NAME=>'CUSTOMER_RAW',
 START_TIME=>DATEADD(DAY,-1,CURRENT_TIMESTAMP())
 )
);

Questions It Answers
---------------------------------------------------------

✓ Which files loaded?
✓ When did they load?
✓ How many rows loaded?

Example
---------------------------------------------------------

customer_01.csv → 1000 rows

customer_02.csv → 1200 rows

Real Use Case
---------------------------------------------------------

Business says:

"customer_01.csv missing."

Check COPY_HISTORY.

=========================================================
5. FIND FAILED FILES
=========================================================

Purpose
---------------------------------------------------------

Identify failed file loads.

Command
---------------------------------------------------------

SELECT *
FROM TABLE(
 INFORMATION_SCHEMA.COPY_HISTORY(
 TABLE_NAME=>'CUSTOMER_RAW',
 START_TIME=>DATEADD(DAY,-1,CURRENT_TIMESTAMP())
 )
)
WHERE STATUS <> 'Loaded';

What To Explain
---------------------------------------------------------

Used by support teams.

Quickly identify:

✓ Failed files
✓ Error status

=========================================================
6. VALIDATE LOAD ERRORS
=========================================================

Purpose
---------------------------------------------------------

Find row-level load errors.

Bad File Example
---------------------------------------------------------

101,John

ABC,Mike

Expected:

CUSTOMER_ID NUMBER

Command
---------------------------------------------------------

SELECT *
FROM TABLE(
 VALIDATE(
 CUSTOMER_RAW,
 JOB_ID => '_LAST'
 )
);

Information Available
---------------------------------------------------------

✓ Error Row
✓ Error Message
✓ File Name

Real Use Case
---------------------------------------------------------

Business asks:

"Why didn't the file load?"

Use VALIDATE.

=========================================================
7. SNOWSIGHT MONITORING
=========================================================

Navigation
---------------------------------------------------------

Monitoring
   ↓
Pipes

Information Available
---------------------------------------------------------

✓ Pipe Status
✓ Files Processed
✓ Throughput
✓ Errors

What To Explain
---------------------------------------------------------

No SQL required.

Provides visual monitoring.

=========================================================
8. ACCOUNT_USAGE MONITORING
=========================================================

Purpose
---------------------------------------------------------

Enterprise-level monitoring.

Command
---------------------------------------------------------

SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.COPY_HISTORY;


Useful for:

✓ Historical Analysis
✓ Dashboard Creation
✓ Audit Reporting

=========================================================
9. CHECK PENDING FILES
=========================================================

Command
---------------------------------------------------------

SELECT SYSTEM$PIPE_STATUS('CUSTOMER_PIPE');

Example Output
---------------------------------------------------------

{
 "pendingFileCount":15
}


15 files waiting.

Possible Reasons:

✓ Notification Delay
✓ Pipe Lag
✓ Processing Issue

=========================================================
10. CHECK NOTIFICATION ISSUES
=========================================================

Command
---------------------------------------------------------

SELECT SYSTEM$PIPE_STATUS('CUSTOMER_PIPE');

Example Output
---------------------------------------------------------

{
 "lastForwardedMessageTimestamp": null
}

S3 Event Notification
is not reaching Snowpipe.

Common Production Issue.

=========================================================
INTERVIEW QUESTION
=========================================================

Question
---------------------------------------------------------

How do you know Snowpipe is working
if no warehouse is running?

Answer
---------------------------------------------------------

Snowpipe is serverless.

Monitor using:

✓ SYSTEM$PIPE_STATUS
✓ COPY_HISTORY
✓ VALIDATE
✓ Snowsight Monitoring
✓ ACCOUNT_USAGE Views

=========================================================
SNOWSIGHT KPI DASHBOARD QUERIES
=========================================================

Files Loaded Today
---------------------------------------------------------

SELECT COUNT(*) AS FILES_LOADED
FROM TABLE(
 INFORMATION_SCHEMA.COPY_HISTORY(
 TABLE_NAME=>'CUSTOMER_RAW',
 START_TIME=>CURRENT_DATE()
 )
);

Rows Loaded Today
---------------------------------------------------------

SELECT SUM(ROW_COUNT) AS ROWS_LOADED
FROM TABLE(
 INFORMATION_SCHEMA.COPY_HISTORY(
 TABLE_NAME=>'CUSTOMER_RAW',
 START_TIME=>CURRENT_DATE()
 )
);

Failed Files Today
---------------------------------------------------------

SELECT COUNT(*) AS FAILED_FILES
FROM TABLE(
 INFORMATION_SCHEMA.COPY_HISTORY(
 TABLE_NAME=>'CUSTOMER_RAW',
 START_TIME=>CURRENT_DATE()
 )
)
WHERE STATUS <> 'Loaded';

Pipe Health Check
---------------------------------------------------------

SELECT SYSTEM$PIPE_STATUS('CUSTOMER_PIPE');

=========================================================
FINAL INTERVIEW ANSWER
=========================================================

We monitor Snowpipe using:

✓ SYSTEM$PIPE_STATUS
✓ COPY_HISTORY
✓ VALIDATE
✓ SHOW PIPES
✓ DESC PIPE
✓ Snowsight Monitoring
✓ ACCOUNT_USAGE Views

In production we create dashboards for:

✓ Files Loaded
✓ Rows Loaded
✓ Failed Loads
✓ Pending Files
✓ Pipe Health