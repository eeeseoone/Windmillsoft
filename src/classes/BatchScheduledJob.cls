global class BatchScheduledJob implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
    // Implement any logic to be scheduled
   
    // We now call the batch class to be scheduled
    BatchPractice b = new BatchPractice();
   
    //Parameters of ExecuteBatch(context,BatchSize)
    database.executebatch(b,200);
    }
   
}