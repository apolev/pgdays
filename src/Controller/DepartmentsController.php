<?php

namespace Controller;

use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;
use Bravicility\Http\Response\Response;

class DepartmentsController extends ControllerAbstract
{
    /**
     * @route GET /departments
     */
    public function index()
    {
        $db          = $this->container->getDb();
        $departments = $db->execute('SELECT * FROM get_departments()')->fetchAll();

        return new HtmlResponse(200, $this->twig->render('departments.twig', array('departments' => $departments)));
    }

    /**
     * @route GET /departments/edit/
     */
    public function get(Request $request)
    {
        $db         = $this->container->getDb();
        $department = $db->execute('SELECT * FROM get_departments(?q)', array($request->get('id')))->fetchOneOrFalse();

        if ($department) {
            return new Response(404, 'Отдел не найден.');
        }

        return new HtmlResponse(200, $this->twig->render('departments.twig', array('department' => $department)));
    }
}
