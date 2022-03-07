const path = require('path')
const db = require(path.resolve(__dirname, '../../db.config'))
const Rol = db.rol 
const Usuario = db.usuario
const Persona = db.persona
const Pedidos = db.pedidos

Pedidos.belongsTo(Persona, {
    foreignKey: 'idpersona',
    sourceKey: 'idpersona',
    targetKey: 'idpersona'
});
Persona.hasMany(Pedidos, {
    foreignKey: 'idpersona',
    sourceKey: 'idpersona',
    targetKey: 'idpersona'
});

Persona.belongsTo(Usuario,{
    foreignKey: 'idpersona',
    sourceKey: 'idpersona',
    targetKey: 'idpersona'
})

Usuario.belongsTo(Persona,{
    foreignKey: 'idpersona',
    sourceKey: 'idpersona',
    targetKey: 'idpersona'
})
Usuario.belongsTo(Rol,{
    foreignKey: 'idrol',
    sourceKey: 'idrol',
    targetKey: 'idrol'
})
Rol.belongsTo(Usuario,{
    foreignKey: 'idrol',
    sourceKey: 'idrol',
    targetKey: 'idrol'
})
/* INGRESO ENTRE DOS TABLAS */


exports.create = (req, res) => {
    var idPersonP;
    var idrol = req.body.idrol;
    var username = req.body.username;
    var password = req.body.password;
    var estado = req.body.estado;
    var utc = req.body.utc;
    Persona.create({
        nombres: req.body.nombres,
        telefono: req.body.telefono,
        correo: req.body.correo,
        dni: req.body.dni,
        estado: req.body.estado,
        utc: req.body.utc,
    }).then(persona => {
        idPersonP = persona.idpersona
        personaCreate(persona.idpersona,idrol, username, password, estado, utc)
        res.json(persona);
    })
    function personaCreate(idpersona,idrol, username, password, estado, utc) {
        Usuario.create({
            idrol: idrol,
            idpersona: idpersona,
            username: username,
            password: password,
            estado: estado,
            utc: utc,
        }).then().catch(err => {
            console.log(err)
        });
    }

};

exports.filterRegistro = (req, res) => {
    Persona.findAll({
        where:{
            dni:req.params.dni
        }
    }).then(usuario_login => {
        if (usuario_login.length > 0) {
            if (usuario_login[0].dataValues.dni) {
                res.json(
                    {
                        "msg": "1",
                        "id_dni": usuario_login[0].dataValues.dni,
                    }
                )
            } else {
                res.json(
                    {
                        "msg": "constraseña incorrecta"
                    }
                )
            }
        } else {
            res.json(
                {
                    "msg": "Usuario no existe"
                }
            )
        }
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })
}


exports.filter = (req, res) => {
    Usuario.findAll({
        where: {
            username: req.params.username
        },
    }).then(usuario_login => {
        if (usuario_login.length > 0) {
            if (usuario_login[0].dataValues.password == req.params.password) {
                res.json(
                    {   
                        "msg": "1",
                        "id_person": usuario_login[0].dataValues.idpersona,
                        "id_rol": usuario_login[0].dataValues.idrol,
                    }
                )
            } else {
                res.json(
                    {
                        "msg": "constraseña incorrecta"
                    }
                )
            }
        } else {
            res.json(
                {
                    "msg": "Usuario no existe"
                }
            )
        }
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })
}




exports.consult = (req, res) => {
    const { Op } = require("sequelize");
    Pedidos.findAll({
        // attributes: ['nombres'],
        where: { 
            idpersona: req.params.idpersona,
            [Op.or]: [
                {
                    estado: 'A'
                },
            ]
    },
       
    }).then(pedidos => {
        res.json(pedidos)
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })

}

exports.consultEnviar = (req, res) => {
    const { Op } = require("sequelize");
    Pedidos.findAll({
        // attributes: ['nombres'],
        where: { 
            idpersona: req.params.idpersona,
            [Op.or]: [
                {
                    estado: 'S'
                }
            ]
    },
       
    }).then(pedidos => {
        res.json(pedidos)
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })

}

exports.consultEliminar = (req, res) => {
    const { Op } = require("sequelize");
    Pedidos.findAll({
        // attributes: ['nombres'],
        where: { 
            idpersona: req.params.idpersona,
            [Op.or]: [
                {
                    estado: 'E'
                }
            ]
    },
       
    }).then(pedidos => {
        res.json(pedidos)
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })

}
//get pedidos web admin
exports.consultwebadmin = (req, res) => {
    const { Op } = require("sequelize");
    Pedidos.findAll({
        where: { 
            [Op.or]: [
                {
                    estado: 'S',
                },
                {
                    estado: 'A'
                },
                {
                    estado: 'E'
                }
            ]
    },
    include:{model:Persona}
       
    }).then(pedidos => {
        res.json(pedidos)
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })

}

exports.perfilUser = (req, res) => {
    const { Op } = require("sequelize");
    Persona.findAll({
        where: {
            idpersona: req.params.idpersona
        },

    }).then(reserva => {
        res.json(reserva)
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            {
                msg: "error", details: err
            }
        )
    })
}


