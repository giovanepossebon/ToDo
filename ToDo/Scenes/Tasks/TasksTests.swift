import Quick
import Nimble

@testable import ToDo

class TasksTests: QuickSpec {
    
    override func spec() {
 
        var view: TasksViewSpy!
        var service: TasksServiceMock!
        var router: TasksViewRouterSpy!
        var presenter: TasksPresenter!
        
        describe("TasksPresenter") {
            
            beforeEach {
                view = TasksViewSpy()
                service = TasksServiceMock()
                let viewModel = TasksPresenter.ViewModel(title: "Market", todoId: 1)
                router = TasksViewRouterSpy()
                presenter = TasksPresenter(view: view, service: service, viewModel: viewModel, router: router)
            }

            describe("when view is loaded") {

                beforeEach {
                    presenter.fetchTasks()
                }

                it("then it should fetch list of tasks") {
                    expect(view.spinnerCalled).to(beTrue())
                    expect(view.spinnerDismissed).to(beTrue())
                    expect(view.tasks?.count) == 2
                }

                context("and there are existing lists of tasks") {
                    it("then it should update view list ordered by creation") {
                        expect(view.showTasksCalled).to(beTrue())
                        expect(view.tasks?[0].created.compare(view.tasks![1].created)) == .orderedDescending
                    }
                }

            }

            describe("when user tries to add a new task") {

                context("and user inserts a invalid task title") {

                    beforeEach {
                        presenter.createTask(name: "")
                    }

                    it("then it shouldn't create a new task") {
                        expect(service.taskCreateCalled).to(beFalse())
                    }

                }

                context("and user inserts a valid task title") {

                    beforeEach {
                        presenter.createTask(name: "egg")

                    }

                    it("then it should create a new task") {
                        expect(service.taskCreateCalled).to(beTrue())
                    }

                }

            }

            describe("when user tries to delete a existent todo list") {

                it("then it should delete it") {
                    presenter.deleteTask(task: Task(id: 1, name: "egg", done: true, todoId: 1, created: Date()))
                    expect(service.deleteTaskCalled).to(beTrue())
                }

            }

            describe("when user tries select to edit an existent task") {

                it("then it should navigate to edit item") {
                    presenter.routeToEdit(with: Task(id: 1, name: "egg", done: false, todoId: 1, created: Date()))
                    expect(router.routeToEditCalled).to(beTrue())
                }

            }

            describe("when user has edited an existent todo list") {

                it("then it should edit it") {
                    presenter.editTask(id: 1, newValue: "milk")
                    expect(view.spinnerCalled).to(beTrue())
                    expect(service.editTaskCalled).to(beTrue())
                    expect(view.spinnerDismissed).to(beTrue())
                    expect(view.error).to(beNil())
                }

            }

        }
    }
}

private class TasksViewSpy: TasksView {
    var tasks: [Task]?
    var showTasksCalled: Bool = false
    var error: String?
    var navigationTitle: String?
    var spinnerCalled: Bool = false
    var spinnerDismissed: Bool = false
    var listRefreshed: Bool = false

    func showTasks(_ tasks: [Task]?) {
        self.tasks = tasks
        showTasksCalled = true
    }

    func showError(_ error: String) {
        self.error = error
    }

    func setNavigationTitle(_ text: String) {
        navigationTitle = text
    }

    func showSpinner() {
        spinnerCalled = true
    }

    func dismissSpinner() {
        spinnerDismissed = true
    }

    func refreshTasksList() {
        listRefreshed = true
    }
}

private class TasksViewRouterSpy: TasksViewRouter {
    var routeToEditCalled: Bool = false

    func routeToEdit(task: Task) {
        routeToEditCalled = true
    }
}

private class TasksServiceMock: TaskServiceContract {
    var taskCreateCalled: Bool = false
    var deleteTaskCalled: Bool = false
    var editTaskCalled: Bool = false

    func fetchTasks(todoId: Int, callback: @escaping (([TaskOutput]?, APIError?) -> Void)) {
        let tasks = [TaskOutput(id: 1, name: "egg", done: false, todoId: 1, createdAt: "", updatedAt: ""),
                     TaskOutput(id: 2, name: "milk", done: true, todoId: 1, createdAt: "", updatedAt: "")]

        callback(tasks, nil)
    }

    func createTask(todoId: Int, input: TaskInput, callback: @escaping (ReturnBool)) {
        taskCreateCalled = true
        callback(true, nil)
    }

    func deleteTask(todoId: Int, itemId: Int, callback: @escaping (ReturnBool)) {
        deleteTaskCalled = true
        callback(true, nil)
    }

    func editTask(todoId: Int, itemId: Int, input: TaskEditInput, callback: @escaping (ReturnBool)) {
        editTaskCalled = true
        callback(true, nil)
    }
}
