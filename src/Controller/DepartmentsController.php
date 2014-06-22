<?php

namespace Controller;

use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;
use Bravicility\Http\Response\RedirectResponse;
use Bravicility\Router\RouteNotFoundException;

class DepartmentsController extends ControllerAbstract
{
    /**
     * @route GET /departments
     */
    public function index()
    {
        $db          = $this->container->getDb();
        $departments = $db->execute('SELECT * FROM get_departments()')->fetchAll();

        return new HtmlResponse(200, $this->twig->render('departments.twig', ['departments' => $departments]));
    }

    /**
     * @route POST /departments/add
     */
    public function doAdd(Request $request)
    {
        $title = $request->post('title');
        $this->container->getDb()->execute('SELECT add_department(?q)', [$title]);

        return new RedirectResponse('/departments');
    }

    /**
     * @route GET /departments/edit/
     */
    public function edit(Request $request)
    {
        $department = $this->getDepartment($request->get('id'));

        return new HtmlResponse(200, $this->twig->render(
            'departments.edit.twig',
            [
                'department'         => $department['data'],
                'availableEmployees' => $department['availableEmployees'],
                'currentEmployees'   => $department['currentEmployees'],
            ]));
    }

    /**
     * @route POST /departments/edit/
     */
    public function doEdit(Request $request)
    {
        $id         = $request->post('id');
        $title      = $request->post('title');
        $department = $this->getDepartment($id);
        $db         = $this->container->getDb();

        $db->execute('SELECT edit_department(?q, ?q)', [$department['id'], $title]);

        return new RedirectResponse('/departments');
    }

    /**
     * @route POST /departments/employees/
     */
    public function doAddEmployee(Request $request)
    {

    }

    /**
     * return array
     */
    private function getDepartment($id)
    {
        $db         = $this->container->getDb();
        $department = $db->execute(
            'SELECT * FROM get_departments(?q)',
            [$id]
        )->fetchOneOrFalse();

        if (!$department) {
            throw new RouteNotFoundException();
        }

        $currentEmployees = $db->execute(
            'SELECT * FROM get_department_employees(?q)',
            [$id]
        )->fetchAll();

        $availableEmployees = $db->execute(
            'SELECT * FROM get_available_for_adding_employees(?q)',
            [$id]
        )->fetchAll();

        return [
            'data'               => $department,
            'currentEmployees'   => $currentEmployees,
            'availableEmployees' => $availableEmployees
        ];
    }
}
