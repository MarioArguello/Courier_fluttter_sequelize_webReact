const path = require('path')
const db = require(path.resolve(__dirname, '../../db.config'))
const Persona = db.persona


//ingresar datos a la tabla
exports.create = (req, res) => {
    Persona.create({
        nombres: req.body.nombres,
        telefono: req.body.telefono,
        correo: req.body.correo,
        dni: req.body.dni,
        estado: req.body.estado,
        utc: req.body.utc,
    }).then(persona => {
        res.json(persona)

    }).catch(err => {
        res.status(500).json({ msg: "error", mensaje: err });
        console.log('mensaje controlado', err)
    });
};

//consultar datos por el id
exports.filter = (req, res) => {
    const id = req.params.idpersona
    var filter = {}
    if (req.params.idpersona > 0) {
        filter = {
            where: {
                idpersona: id
            }
        }
    }
    Persona.findAll(filter).then(persona => {
        res.json(persona);
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            msg: "error", details: err
        });
    });
}

// Consultar todos los datos de la tabla 
exports.findAll = (req, res) => {
    Persona.findAll()
        .then(persona => {
            res.send(persona);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving data."
            });
        });
};

//Actualizar todos los datos de la tabla
exports.update = (req, res) => {
    Persona.update({
        nombres: req.body.nombres,
        telefono: req.body.telefono,
        correo: req.body.correo,
        dni: req.body.dni,
        estado: req.body.estado,
        utc: req.body.utc,
    },
        {
            where: {
                idpersona: req.params.idpersona,
            }
        })
        .then(() => {
            res.status(200).json(req.body);
        }).catch(err => {
            console.log(err);
            res.status(500).json({
                msg: "error", details: err
            });
        });
};


//Eliminar un registro de la tabla por id
exports.delete = (req, res) => {
    const id = req.params.idpersona;
    Persona.destroy({
        where: { idpersona: id },
    }).then(() => {
        res.status(200).json({ msg: 'Registro eliminado -> Representante cedula = ' + id });
    }).catch(err => {
        console.log(err);
        res.status(500).json({ msg: "error", details: err });
    });
};