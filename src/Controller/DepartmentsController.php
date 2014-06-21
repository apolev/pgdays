<?php

namespace Controller;

use Bravicility\Http\Response\HtmlResponse;

class DepartmentsController extends ControllerAbstract
{
    /**
     * @route GET /departments
     */
    public function index()
    {
        $db = $this->container->getDb();
        $db->execute(' SELECT * FROM get_departments()');
        return new HtmlResponse(200, $this->twig->render('departments.twig'));
    }
}
