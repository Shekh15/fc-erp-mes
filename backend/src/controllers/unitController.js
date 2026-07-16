const Unit = require('../models/Unit');

exports.getAll = async (req,res,next) => {

  try {

    const data = await Unit.getAll();

    res.json(data);

  } catch(err){

    next(err);

  }

};

exports.create = async (req,res,next) => {

  try {

    const id = await Unit.create(req.body);

    res.status(201).json({
      message:'Unit created successfully',
      id
    });

  } catch(err){

    next(err);

  }

};

exports.update = async (req,res,next) => {

  try {

    await Unit.update(
      req.params.id,
      req.body
    );

    res.json({
      message:'Unit updated successfully'
    });

  } catch(err){

    next(err);

  }

};

exports.deactivate = async (req,res,next) => {

  try {

    await Unit.deactivate(
      req.params.id
    );

    res.json({
      message:'Unit deleted successfully'
    });

  } catch(err){

    next(err);

  }

};