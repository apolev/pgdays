<?php

namespace Controller;

use BadRequestException;
use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;
use Bravicility\Http\Response\RedirectResponse;
use Bravicility\Router\RouteNotFoundException;

class EmployeesController extends ControllerAbstract
{

    /**
     * @route GET /employees/
     */
    public function index()
    {
        $db          = $this->container->getDb();
        $employees = $db->execute('SELECT * FROM get_employees()')->fetchAll();

        return new HtmlResponse(200, $this->twig->render('employees.twig', ['employees' => $employees]));
    }

    /**
     * @route GET /employees/multi-departments
     */
    public function multiDepartments()
    {
        $db        = $this->container->getDb();
        $employees = $db->execute('SELECT * FROM get_employees_with_multi_departments()')->fetchAll();

        return new HtmlResponse(200, $this->twig->render('employees.report.twig', ['employees' => $employees]));
    }

    /**
     * @route POST /employees/add
     */
    public function doAdd(Request $request)
    {
        $title = $request->post('title');
        $this->container->getDb()->execute('SELECT add_employee(?q)', [$title]);

        return new RedirectResponse('/employees/');
    }

    /**
     * @route GET /employees/edit
     */
    public function edit(Request $request)
    {
        $employee = $this->getEmployee($request->get('id'));

        return new HtmlResponse(200, $this->twig->render('employees.edit.twig', ['employee' => $employee]));
    }

    /**
     * @route POST /employees/edit
     */
    public function doEdit(Request $request)
    {
        $id       = $request->post('id');
        $title    = $request->post('title');
        $employee = $this->getEmployee($id);
        $db       = $this->container->getDb();

        $db->execute('SELECT edit_employee(?q, ?q)', [$employee['id'], $title]);

        return new RedirectResponse('/employees');
    }

    /**
     * @route POST /employees/remove
     */
    public function doRemove(Request $request)
    {
        $ids = $request->post('ids', []);
        $db  = $this->container->getDb();

        $db->execute(
            'SELECT remove_employees(array[?l]::integer[])',
            [$ids]
        );

        return new RedirectResponse('/employees');
    }

    public function getEmployee($id)
    {
        $id = (int) $id;
        if (!$id) {
            throw new BadRequestException();
        }

        $db       = $this->container->getDb();
        $employee = $db->execute(
            'SELECT * FROM get_employees(?q)',
            [$id]
        )->fetchOneOrFalse();

        if (!$employee) {
            throw new RouteNotFoundException();
        }

        return $employee;
    }
}
