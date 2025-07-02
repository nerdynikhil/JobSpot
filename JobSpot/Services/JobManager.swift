import Foundation
import Combine

class JobManager: ObservableObject {
    @Published var savedJobs: [Job] = []
    @Published var appliedJobs: [Job] = []
    
    private let userDefaults = UserDefaults.standard
    private let savedJobsKey = "savedJobs"
    private let appliedJobsKey = "appliedJobs"
    
    init() {
        loadSavedJobs()
        loadAppliedJobs()
    }
    
    func saveJob(_ job: Job) {
        if !savedJobs.contains(where: { $0.id == job.id }) {
            savedJobs.append(job)
            saveSavedJobs()
        }
    }
    
    func unsaveJob(_ job: Job) {
        savedJobs.removeAll { $0.id == job.id }
        saveSavedJobs()
    }
    
    func applyToJob(_ job: Job) {
        if !appliedJobs.contains(where: { $0.id == job.id }) {
            appliedJobs.append(job)
            saveAppliedJobs()
        }
    }
    
    func isJobSaved(_ job: Job) -> Bool {
        savedJobs.contains { $0.id == job.id }
    }
    
    func isJobApplied(_ job: Job) -> Bool {
        appliedJobs.contains { $0.id == job.id }
    }
    
    private func saveSavedJobs() {
        // In a real app, you'd encode the jobs to Data
        // For now, we'll just store the job IDs
        let jobIds = savedJobs.map { $0.id }
        userDefaults.set(jobIds, forKey: savedJobsKey)
    }
    
    private func loadSavedJobs() {
        // In a real app, you'd decode the jobs from Data
        // For now, we'll just load from mock data
        savedJobs = MockDataService.generateJobs().prefix(2).map { $0 }
    }
    
    private func saveAppliedJobs() {
        let jobIds = appliedJobs.map { $0.id }
        userDefaults.set(jobIds, forKey: appliedJobsKey)
    }
    
    private func loadAppliedJobs() {
        appliedJobs = MockDataService.generateJobs().prefix(1).map { $0 }
    }
} 