module.exports = (sequelize, Sequelize)=> {
    const Rol = sequelize.define('rol',{
        idrol: {
            type: Sequelize.UUID,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        nombre: {
            type: Sequelize.STRING,
        },
        estado: {
            type: Sequelize.STRING,
        },
        utc: {
            type: Sequelize.DATE,
        }
    },
    { timestamps: false})
    return Rol
}