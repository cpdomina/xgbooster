import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import ml.dmlc.xgboost4j.LabeledPoint;
import ml.dmlc.xgboost4j.java.Booster;
import ml.dmlc.xgboost4j.java.DMatrix;
import ml.dmlc.xgboost4j.java.XGBoost;


public class xg {
	public static void main(String[] args) throws Exception {

		List<LabeledPoint> aData = new ArrayList<>();
		for (int i = 0; i < 4; i++) {
			aData.addAll(Arrays.asList(
				new LabeledPoint(0, new int[]{1000, 100000}, new float[]{0, 1}),
				new LabeledPoint(1, new int[]{999, 100000}, new float[]{1, 0}),
				new LabeledPoint(2, new int[]{100000, 1}, new float[]{1, 1})
			));
		}

		DMatrix aMatrix = new DMatrix(aData.iterator(), "");

		HashMap<String, Object> aParams = new HashMap<>();
		aParams.put("objective", "reg:linear");

		Booster booster = XGBoost.train(aMatrix, aParams, 10, new HashMap<>(), null, null);

		for (float[] val: booster.predict(aMatrix)) {
			System.out.println(Arrays.toString(val));
		}
	}
}
