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
     * @route POST /employees/add
     */
    public function doAdd(Request $request)
    {
        $db    = $this->container->getDb();
        $title = $request->post('title');

        $this->container->getDb()->execute('SELECT add_employee(?q)', [$title]);

        return new RedirectResponse('/employees/');
    }

    public function edit()
    {

    }

    public function doEdit()
    {

    }
}
