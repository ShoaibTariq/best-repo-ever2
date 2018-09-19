trigger testAccount on Account (after insert) {
    for(Account t :trigger.new) {
        t.industry ='agriculture';
    }
}