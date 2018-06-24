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
                    it("then it should update view list ordered by creation") {
                        expect(view.listTodosCalled).to(beTrue())
                        expect(view.todos?[0].created.compare(view.todos![1].created)) == .orderedDescending
                    }
                }

            }

            describe("when user tries to add a new todo list") {

                context("and user inserts a invalid todo list title") {

                    beforeEach {
                        presenter.createTodo(title: "")
                    }

                    it("then it shouldn't create a new todo list") {
                        expect(service.todoCreateCalled).to(beFalse())
                    }

                }

                context("and user inserts a valid todo list title") {

                    beforeEach {
                        presenter.createTodo(title: "Market")

                    }

                    it("then it should create a new todo list") {
                        expect(service.todoCreateCalled).to(beTrue())
                    }

                }

            }

            describe("when user tries to delete a existent todo list") {

                it("then it should delete it") {
                    presenter.deleteTodo(Todo(id: 0, title: "", created: Date(), updated: Date()))
                    expect(service.todoDeleteCalled).to(beTrue())
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

            describe("when user has edited an existent todo list") {

                it("then it should edit it") {
                    presenter.editTodo(with: 1, newTitle: "Market")
                    expect(view.spinnerCalled).to(beTrue())
                    expect(service.todoEditCalled).to(beTrue())
                    expect(view.spinnerDismissed).to(beTrue())
                    expect(view.error).to(beNil())
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

    func toTodoEdit(id: Int, title: String) {
        toTodoEditCalled = true
    }
}

private class TodoServiceMock: TodoServiceContract {
    var todoCreateCalled: Bool = false
    var todoDeleteCalled: Bool = false
    var todoEditCalled: Bool = false

    func fetchTodos(callback: @escaping (([TodoOutput]?, APIError?) -> Void)) {
        let todos = [TodoOutput(id: 0, title: "Market", createdBy: "1", createdAt: "2018-06-24T14:55:42.603Z", updatedAt: "2018-06-24T14:56:40.706Z"),
                     TodoOutput(id: 1, title: "Homework", createdBy: "2", createdAt: "2018-06-24T14:56:14.788Z", updatedAt: "2018-06-24T14:57:44.676Z")]

        callback(todos, nil)
    }

    func createTodo(input: TodoInput, callback: @escaping ((TodoOutput?, APIError?) -> Void)) {
        todoCreateCalled = true
        callback(TodoOutput(id: 0, title: "Market", createdBy: "1", createdAt: "2018-06-24T14:55:42.603Z", updatedAt: "2018-06-24T14:56:40.706Z"), nil)
    }

    func deleteTodo(id: Int, callback: @escaping (ReturnBool)) {
        todoDeleteCalled = true
        callback(true, nil)
    }

    func editTodo(id: Int, input: TodoInput, callback: @escaping (ReturnBool)) {
        todoEditCalled = true
        callback(true, nil)
    }
}
