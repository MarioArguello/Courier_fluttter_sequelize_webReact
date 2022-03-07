module.exports = (sequelize, Sequelize)=> {
    const Usuario = sequelize.define('usuario',{
        idusuario: {
            type: Sequelize.UUID,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        idpersona: {
            type: Sequelize.INTEGER,
        },
        idrol: {
            type: Sequelize.INTEGER,
        },
        username: {
            type: Sequelize.STRING,
        },
        password: {
            type: Sequelize.STRING,
        },
        estado: {
            type: Sequelize.STRING,
        },
        utc: {
            type: Sequelize.DATE,
        },
    },
    { timestamps: false})
    
    return Usuario
}