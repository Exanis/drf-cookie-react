import { push } from 'react-router-redux';

export default store => next => action => {
    if (!action['API_CALL']) {
        return next(action);
    }
    const {
        request,
        path,
        sendingAction,
        successAction,
        failureAction
    } = action['API_CALL'];
    const { dispatch } = store;

    if (sendingAction !== null)
        dispatch(sendingAction);
    fetch(path, request)
        .then(result => {
            if (result.ok) {
                if (successAction !== null) {
                    result.json().then(function (value) {
                        dispatch({
                            type: successAction,
                            result: value
                        });
                    });
                }
            } else {
                if (failureAction !== null) {
                    result.json().then(function (value) {
                        dispatch({
                            type: failureAction,
                            result: value
                        });
                    }).catch(function () {
                        dispatch({
                            type: failureAction,
                            result: []
                        });
                    });
                }
            }
        })
        .catch(error => {
            dispatch({
                type: failureAction,
                result: error
            });
        });
};