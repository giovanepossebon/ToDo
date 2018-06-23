import Quick
import Nimble

@testable import ToDo

class TodoTests: QuickSpec {

    override func spec() {

        var view: TodoViewSpy!
        var router: TodoViewRouterSpy!
        var service: TodoServiceMock!
        var presenter: TodoPresenter!

        describe("TodoPresenter") {

            beforeEach {
                view = TodoViewSpy()
                router = TodoViewRouterSpy()
                service = TodoServiceMock()
                presenter = TodoPresenter(view: view, service: service, router: router)
            }

            describe("when view is loaded") {

                beforeEach {
                    presenter.fetchTodoList()
                }

                it("then it should fetch list of todos") {
                    expect(view.spinnerCalled).to(beTrue())
                    expect(view.spinnerDismissed).to(beTrue())
                    expect(view.todos?.count) == 2
                }

                context("and there are existing lists of todos") {
                    it("then it should update view list") {
                        expect(view.listTodosCalled).to(beTrue())
                    }
                }

            }

            describe("when user tries to add a new todo list") {

                context("and user inserts a invalid todo list title") {

                    beforeEach {
                        presenter.createTodo(title: "")
                    }

                    it("then it shouldn't create a new todo list") {
                        expect(service.todoCreated).to(beFalse())
                    }

                }

                context("and user inserts a valid todo list title") {

                    beforeEach {
                        presenter.createTodo(title: "Market")

                    }

                    it("then it should create a new todo list") {
                        expect(service.todoCreated).to(beTrue())
                    }

                }

            }

            describe("when user tries to delete a existent todo list") {

                it("then it should delete it") {
                    presenter.deleteTodo(Todo(id: 0, title: "", created: Date(), updated: Date()))
                    expect(service.todoDeleted).to(beTrue())
                }

            }

            describe("when user select a todo list cell") {

                it("then it should navigate to list of items") {
                    presenter.showTodoList(todo: Todo(id: 0, title: "", created: Date(), updated: Date()))
                    expect(router.toTodoListCalled).to(beTrue())
                }

            }

            describe("when user tries select to edit an existent todo list") {

                it("then it should navigate to edit item") {
                    presenter.editTodoList(todo: Todo(id: 0, title: "", created: Date(), updated: Date()))
                    expect(router.toTodoEditCalled).to(beTrue())
                }

            }
        }
    }
}

private class TodoViewSpy: TodoView {
    var todos: [Todo]?
    var listTodosCalled: Bool = false
    var error: String?
    var spinnerCalled: Bool = false
    var spinnerDismissed: Bool = false
    var refreshTodoListCalled: Bool = false

    func setTodoList(_ todos: [Todo]?) {
        self.todos = todos
        listTodosCalled = true
    }

    func showError(_ error: String) {
        self.error = error
    }

    func showSpinner() {
        spinnerCalled = true
    }

    func dismissSpinner() {
        spinnerDismissed = true
    }

    func refreshTodoList() {
        refreshTodoListCalled = true
    }
}

private class TodoViewRouterSpy: TodoViewRouter {
    var toTodoListCalled: Bool = false
    var toTodoEditCalled: Bool = false

    func toTodoList(id: Int, title: String) {
        toTodoListCalled = true
    }

    func toTodoEdit(id: Int) {
        toTodoEditCalled = true
    }
}

private class TodoServiceMock: TodoServiceContract {
    var todos: [Todo]?
    var todoCreated: Bool = false
    var todoDeleted: Bool = false

    func fetchTodos(callback: @escaping (([TodoOutput]?, APIError?) -> Void)) {
        let todos = [TodoOutput(id: 0, title: "Market", createdBy: "1", createdAt: "02-27-2018", updatedAt: "02-21-2018"),
                     TodoOutput(id: 1, title: "Homework", createdBy: "2", createdAt: "02-28-2018", updatedAt: "02-05-2018")]

        callback(todos, nil)
    }

    func createTodo(input: TodoInput, callback: @escaping ((TodoOutput?, APIError?) -> Void)) {
        todoCreated = true
    }

    func deleteTodo(id: Int, callback: @escaping (ReturnBool)) {
        todoDeleted = true
    }
}
